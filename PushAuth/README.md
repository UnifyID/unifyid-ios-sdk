# Getting Started with UnifyID PushAuth iOS SDK

Before following this guide, follow the [Getting Started](./../README.md) guide to set up the `UnifyID` SDK

## PushAuth

UnifyID provides a way for websites to request a second factor authentication from a user's mobile device using Apple Push Notification service.  This reduces the friction of users manually entering TOTP codes, having to install 3rd party authenticator apps, or pay prohibitively expensive SMS delivery charges -- all while providing real time second factor authentication from your own mobile apps user interface.

UnifyID PushAuth uses the same Apple Push Notification service channel that your app may already be using, and as such provides mechanisms to allow you to continue to use those along side the new PushAuth notifications.

## Create Apple Push Notification service (APNs) certificate

Before using the SDK, you'll need to upload your Apple Push Certificate to the [UnifyID Developer Dashboard](https://dashboard.unify.id).  If you haven't already generated one for your app, you'll need to do so in the [Apple Developer Account Certificates Portal](https://developer.apple.com/account/resources/certificates/list).  Make sure to choose:

`Apple Push Notification Service SSL`

If you would like to use this certificate during development, generate a `Sandbox & Production` certificate.  Once you've downloaded that certificate, go into your keychain and export the private key that was used for the push certificate as a `p12` file, and choose to export without a password.

![Export P12 from Keychain](./img/export_p12.png)

You can then upload that certificate to the UnifyID Dashboard for your app (Use a different app target for "sandbox") and push should be enabled.

## Access UnifyID PushAuth iOS SDK

After initializing `UnifyID`, you can now obtain the `PushAuth` instance.

> NOTE: `UnifyID.user` must be set as it is the value your server will need in order to send push notifications directly to the user.

```swift
import PushAuth
let pushAuth = unify.pushAuth
```

## Register Push Token

In order for your app to get PushAuth Notifications, you will need to register your app's push token (from Apple) with our backend services.  To do that, add a listener for updated device tokens to your `UIApplicationDelegate`:

```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
{
    pushAuth.registerPushToken(token) { (error) in
        guard error == nil else {
            self.handleError("Subscribe Error", error: error)
            return
        }
        // Registered!
    }
    // Optional: Send the device token for use with your apps other push notifications
}
```

This register call should be made every time you get a device token, as sometimes Apple rotates.  PushAuth pushes will be sent from our service after the first successful registeration, and will continue to be sent unless the token becomes invalid.

> NOTE: `didRegisterForRemoteNotificationsWithDeviceToken` only gets called if you have requested push auth permissions from your user, and they have accepted
>
> ```swift
> UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert])
> { (authorized, error) in
>   // ...
> }
> ```
>

## Retrieve from Push Notification

There are two ways that Apple can forward you a push notification:

1. If your application is in the background, then Apple will display the notification for the user and they can select the notification itself, or one of the buttons "Accept" or "Reject".  *After* the user makes a selection, Apple will wake your app up and call `userNotificationCenter(_:didReceive:withCompletionHandler:)` on your app's [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate) as a `UNNotificationResponse` object.
2. If your application is in the foreground, then Apple *will not* prompt the user and will instead pass the request directly to your [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate) through the `userNotificationCenter(_:willPresent:withCompletionHandler:)` method and a `UNNotification` object.

`PushAuth` lets you attempt to convert `UNNotification` and `UNNotificationResponse` objects into a `PushAuthRequest` object. If the notification is not a PushAuth notification from UnifyID (eg, one of your own push notifications), then the method returns `nil` allowing you to treat it as a normal push:

```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if let pushAuthRequest = pushAuth.pushAuthRequest(response) {
        switch pushAuthRequest.userResponse {
        case .accept, .decline: // User responded from notification
            // Skip presenting if you like, and send user response direct
        case .unknown:
            // User tapped main body and did not make a response, present request
        }
    }
}

func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    if let pushAuthRequest = unify?.pushAuth.pushAuthRequest(notification) {
        // No user response will be available, present to user
    }
}
```

## Retrieve Pending PushAuth Requests

In order to check pending push authentication requests, or requests that were somehow not delivered by APNs, you can periodically, or manually call to retrieve a list from UnifyID using `PushAuth.getPendingAuthenticationRequests(completion:)`:

```swift
pushAuth.getPendingAuthenticationRequests { (result) in
    switch (result) {
    case .success(let requests):
        guard requests.count > 0 else {
            // No Pending Results
            return
        }
        // Handle pending requests
    case .failure(let error):
        // Error Handling
    }
}
```

## Respond to Push Request

Once you have a `PushAuthRequest`, either from pending or direct from APNs, you can present whatever UI that you would like, and then send the response directly from the request object using `PushAuthRequest.respond(_:completion:)`.  You can send `PushAuthRequest.userResponse` or your own response using the `DirectResponse` class.  For `DirectResponse` you can also specify a detail string which will be sent to the server and will be returned when you query the request's status from the API.

```swift
pushAuthRequest.respond(DirectResponse.accept("Optional detail string"))
// or
pushAuthRequest.respond(DirectResponse.reject())
// or
pushAuthRequest.respond(pushAuthRequest.userResponse)
```

## Present Request

If there is no user response present, or you would like to prompt the user and don't want to design your own UI, the `PushAuthRequest.presentAsAlert(_:completion:)` method will present the request as an alert from the view controller you pass and send the result to the server directly.

```swift
pushAuthRequest.presentAsAlert(vc) { result
    /// Result is an error, or the result that user selected and was sent to server
}
```
