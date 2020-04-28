// Copyright © 2019 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.

import UIKit
import UserNotifications
import PushAuth

class PushAuthVC : UnifyVC, UNUserNotificationCenterDelegate {
    var status : String = "Uninitialized"
    var token : String?

    lazy var pushAuthLabel : UILabel = {
        styledLabel(text: "Status: \(status)", style: .title3)
    }()

    lazy var tokenButton : UIButton = {
        styledButton("Register Push Token", selector: #selector(getToken))
    }()

    lazy var pendingButton : UIButton = {
        let button = styledButton("Get Pending PushAuth", selector: #selector(getPending))
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews([
            pushAuthLabel,
            tokenButton,
            pendingButton
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDeviceToken(_:)), name: AppDelegate.didReceiveDeviceToken, object: nil)
        UNUserNotificationCenter.current().delegate = self
    }

    @objc func getToken() {
        guard Self.unify != nil else {
            openSettings()
            return
        }
        setAlert("Push Token",
                 message: "Push token can be retrieved from device, or set manually for testing.",
                 value: token,
                 actions: [
                    { alert in
                        UIAlertAction(title: "Get Device Token", style: .default) { (_) in
                            self.registerPushAuth()
                            alert.textFields![0].text = nil
                        }
                    }
            ])
        { (token) -> Bool in
            if let token = token {
                self.token = token
                self.updateButtons()
                self.subscribePushAuth()
            }
            return true
        }
    }

    internal func registerPushAuth() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                switch (settings.alertSetting) {
                case .disabled, .notSupported:
                    center.requestAuthorization(options: [.sound, .alert]) { (authorized, error) in
                        guard error == nil else {
                            self.handleError("Error registering", error: error)
                            return
                        }
                        guard authorized else {
                            self.handleError("Missing user authorization")
                            return
                        }
                        self.registerPushAuth()
                    }
                case .enabled:
                    DispatchQueue.main.async {
                        self.status = "Requesting Apple Token..."
                        self.updateButtons()
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                @unknown default:
                    self.handleError("Invalid Settings Response", message: "\(self)")
                }
            }
        }
    }

    @objc internal func getPending() {
        guard let pushAuth = Self.unify?.pushAuth else {
            openSettings()
            return
        }
        pushAuth.getPendingAuthenticationRequests { (result) in
            switch (result) {
            case .success(let results):
                guard results.count > 0 else {
                    self.alert("No pending results")
                    return
                }
                results.forEach({ $0.presentAsAlert(self) { (result) in
                    switch (result) {
                    case .success(let response):
                        self.alert("Responded: \(response)")
                    case .failure(let error):
                        self.handleError("Push Response Error", error: error)
                    }
                    } })
            case .failure(let error):
                self.handleError("Fetch pending error", error: error)
            }
        }
    }

    func updateButtons() {
        DispatchQueue.main.async {
            self.pushAuthLabel.text = "Status: \(self.status)"
            if let token = self.token {
                self.updateButton(self.tokenButton, "Change Push Token", token)
            }
            self.pendingButton.isHidden = Self.unify == nil
            self.view.setNeedsLayout()
        }
    }

    override func handleError(
        _ title: String,
        message: String? = nil,
        error: Error? = nil,
        actions: UnifyVC.AlertActions? = nil,
        textFields: UnifyVC.TextFields? = nil)
    {
        status = "\(title)"
        updateButtons()
        super.handleError(title, message: message, error: error, actions: actions, textFields: textFields)
    }

    @objc func didReceiveDeviceToken(_ notification: Notification) {
        guard let token = notification.object as? String else {
            handleError("Token format error", message: "\(notification.object.debugDescription)")
            return
        }
        DispatchQueue.main.async {
            self.status = "Subscribing UnifyID..."
            self.token = token
            self.updateButtons()
            self.subscribePushAuth()
        }
    }

    func subscribePushAuth() {
        guard let pushAuth = Self.unify?.pushAuth, let token = token else {
            openSettings()
            return
        }
        pushAuth.registerPushToken(token) { (error) in
            guard error == nil else {
                self.handleError("Subscribe Error", error: error)
                return
            }
            DispatchQueue.main.async {
                self.status = "Subscribed"
                self.updateButtons()
            }
        }
    }

    func alertPushResult(_ result: Result<UserResponse, PushAuthError>) {
        switch result {
        case .success(let userResponse):
            switch userResponse {
            case .accept:
                self.alert("PushAuth Accepted")
            case .decline:
                self.alert("PushAuth Declined")
            default: break
            }
        case .failure(let error):
            self.handleError("Error sending response", error: error)

        }
    }

    private func presentPushAuth(_ pushAuthRequest: PushAuthRequest) {
        pushAuthRequest.presentAsAlert(self) { result in
            self.alertPushResult(result)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        defer {
            completionHandler()
        }
        guard let pushAuth = Self.unify?.pushAuth else {
            handleError("SDK not initialized", message: "Notification arrived before SDK Initialized.")
            return
        }
        if let pushAuthRequest = pushAuth.pushAuthRequest(response) {
            switch pushAuthRequest.userResponse {
            case .accept, .decline: // User responded from notification
                pushAuthRequest.respond(pushAuthRequest.userResponse) { (error) in
                    self.alertPushResult(error != nil ? Result<UserResponse, PushAuthError>.failure(error!)
                        : Result<UserResponse, PushAuthError>.success(pushAuthRequest.userResponse))
                }
            case .unknown:
                self.presentPushAuth(pushAuthRequest)
            @unknown default:
                break
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        defer {
            completionHandler(UNNotificationPresentationOptions())
        }
        guard let pushAuth = Self.unify?.pushAuth else {
            handleError("SDK not initialized", message: "Notification arrived before SDK Initialized.")
            return
        }
        if let pushAuthRequest = pushAuth.pushAuthRequest(notification) {
            self.presentPushAuth(pushAuthRequest)
        }
    }
}
