# UnifyID iOS Sample

This Xcode Swift project is provided as a reference example for implementing UnifyID iOS components in your own project.

## Building

After pulling the repository and changing into the sample directory, you'll need to install the CocoaPods using:

`pod install`

This should update to the latest CocoaPod for the demo project and get you ready to go.  After that open `UnifyIDDemo.xcworkspace` to build and run the project for simulator.

## Running

The demo allows you to input your own SDK Key, User Name, and if configured (not normal) a challenge token for authorizing your client.

### HumanDetect

Run the app on a device as Simulator registers as "non-human" for the purposes of HumanDetect.  While the HumanDetect tab is open our SDK is configured to collect passive signal for generating a HumanDetect token.  Pressing "Generate HumanDetect Token" will trigger token generation, and will present a token string, or an error message on failure.  You can copy this token string for testing your backend as needed.

### PushAuth

In order to test Push Authorization, you'll need to set a bundle identifier that you have configured Apple Push service for (See [Ray Wenderlich's great tutorial](https://www.raywenderlich.com/8164-push-notifications-tutorial-getting-started)).  Upload a Sandbox / Production (hybrid) P12 to our [developer portal](https://developer.unify.id) for your project that matches the bundle ID you've setup, and for local builds make sure to check "sandbox" when uploading.

Run the app on a device, as APNs won't push to simulator.  Configure the iOS Demo app with an SDK Key generated from the same project that you upload the certificate to, and a user string that you can remember (You'll need it later).  Switch to PushAuth tab and tap "Register Push Token".  In the dialog, select "Get Device Token".  If everything is configured correctly you should see your devices token and "Status: Subscribed"

You can now test sending push authentication using an API Key from the same project and your website, or try pushing using a curl request.  For curl request open a terminal and export your projects API Key and the User you want to push to using:

```sh
export UNIFYID_API_KEY="api_key_pasted_from_developer_portal"
```

Then, you should be able to push using curl:

> NOTE: Make sure to replace 'username' with the username you set in the mobile sample app

```sh
curl -H 'accept: application/json' \
-H "x-api-key: $UNIFYID_API_KEY" \
--data '{
  "notification":{
  "title":"A Test Push Notification",
  "subtitle":"Lovingly sent from cURL",
  "body":"It even has a body!"
},
"user":"username"}' \
--request POST https://api.unify.id/v1/push/sessions
```
