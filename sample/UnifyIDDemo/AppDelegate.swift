// Copyright © 2019 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.

import UIKit
import UnifyID



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let didReceiveDeviceToken : Notification.Name = Notification.Name(rawValue: "AppDelegate.didRegisterForRemoteNotificationsWithDeviceToken")

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        // UnifyID works with `Data` or `String` tokens, string is easier to use
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        NotificationCenter.default.post(Notification(name: AppDelegate.didReceiveDeviceToken, object: tokenString))
    }
}

