// Copyright © 2019 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.

import UIKit
import UnifyID

final class SettingsVC : UnifyVC {
    struct Configuration : Codable {
        var challenge : String? = nil
        var registeredToken : String? = nil
        var sdkKey : String? = nil
        var user : String? = nil
    }

    var configuration : Configuration {
        get {
            if let data = UserDefaults.standard.value(forKey: "configuration") as? Data,
                let configuration = try? JSONDecoder().decode(Configuration.self, from: data) {
                return configuration
            }
            return Configuration()
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "configuration")
                UserDefaults.standard.synchronize()
            }
            updateButtonLabels()
        }
    }

    lazy var sdkKeyButton : UIButton = {
        styledButton("Set SDK Key", selector: #selector(getSDKKey))
    }()

    lazy var challengeButton : UIButton = {
        styledButton("Set Challenge", selector: #selector(getChallenge))
    }()

    lazy var userButton : UIButton = {
        styledButton("Set User", selector: #selector(getUser))
    }()

    lazy var reloadButton : UIButton = {
        styledButton("SDK Not Initialized", selector: #selector(startUnify))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews([
            sdkKeyButton,
            challengeButton,
            userButton,
            reloadButton
        ])
        updateButtonLabels()
        startUnify()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateButtonLabels()
    }

    @objc private func startUnify() {
        let config = configuration
        guard let key = config.sdkKey else {
            getSDKKey()
            return
        }
        do {
            Self.unify = try UnifyID(
                sdkKey: key,
                user: config.user,
                challenge: config.challenge ?? "")
        } catch (let error) {
            handleError("Unable to Initialize", error: error, actions: [
                { _ in UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                    self.getSDKKey()
                }) }
            ])
            return
        }
    }

    internal func updateButtonLabels() {
        let config = self.configuration
        DispatchQueue.main.async {
            if let sdkKey = config.sdkKey {
                self.updateButton(self.sdkKeyButton, "SDK Key", sdkKey)
            }

            if let user = config.user {
                self.updateButton(self.userButton, "User", user)
            } else if let unify = Self.unify {
                self.updateButton(self.userButton, "Generated User", unify.user)
            }

            if let challenge = config.challenge {
                self.updateButton(self.challengeButton, "Challenge", challenge)
            }

            if let unify = Self.unify {
                if let clientID = unify.clientID {
                    self.updateButton(self.reloadButton, "Reload SDK Client", clientID)
                } else {
                    self.updateButton(self.reloadButton, "Reload SDK Client","No Client ID Assigned")
                }
            }

            self.view.setNeedsLayout()
        }
    }

    @objc internal func getSDKKey() {
        setAlert("SDK Key",
                 message: "UnifyID Requires an SDK key, you can get one from https://dashboard.unify.id",
                 value: self.configuration.sdkKey,
                 actions: [ { _ in
                    UIAlertAction(title: "Get Key", style: .default) { (_) in
                        UIApplication.shared.open(URL(string: "https://dashboard.unify.id")!)
                    }}])
        { (sdkKey) -> Bool in
            guard let sdkKey = sdkKey, let _ = URL(string: sdkKey) else {
                return false // Replay
            }
            self.configuration.sdkKey = sdkKey
            self.startUnify()
            return true
        }
    }

    @objc private func getUser() {
        setAlert("SDK User",
                 message: "SDK User is an optional field that represents app user to the server.  Should not contain personally identifiable information.  Can be any string.",
                 value: self.configuration.user)
        { (user) -> Bool in
            self.configuration.user = user
            self.startUnify()
            return true
        }
    }

    @objc private func getChallenge() {
        setAlert("Challenge String",
                 message: "This SDK Key requires a challenge string to authenticate, or the challenge string you provided is invalid",
                 value: self.configuration.challenge,
                 actions: [{ _ in
                    UIAlertAction(title: "Change SDK Key", style: .cancel) { (_) in
                        self.getSDKKey()
                    }
                    }])
        { (challenge) -> Bool in
            self.configuration.challenge = challenge
            self.startUnify()
            return true
        }
    }
}



