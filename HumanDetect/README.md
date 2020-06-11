# Getting Started with UnifyID HumanDetect

Before following this guide, follow the [Getting Started](./UnifyID) guide to setup the `UnifyID` SDK

## HumanDetect

UnifyID HumanDetect provides a mechanism to generate passive [CAPTCHA](https://en.wikipedia.org/wiki/CAPTCHA) tokens.  These tokens can be sent to remote API as a verification that the caller of the API is a human, using your mobile application.  HumanDetect functionality is accessed through the `UnifyID.humanDetect` SDK instance you allocated [earlier](./UnifyID) and uses the user and SDK Key provided to that.

```swift
import HumanDetect
let humanDetect = unify.humanDetect
```

## Start data capture

In order to tell the difference between a phone on a rack and a one being held by a human the SDK currently needs 2 seconds of passive data collection before being able to generate a token.  You can start this collection whenever you like.

```swift
humanDetect.startPassiveCapture()
```

## Generate HumanDetect Token

When you are ready to make an authenticated API call (one that requires a humanDetect token), you should generate a token.  This call is synchronous and generates a token based on the last 2 seconds of captured passive data.  You can then check that result for success (token) or failure (error).  An `identifier` should be provided, this value is embedded into the token and can be securely verified by the API for extra security.

```swift
switch humanDetect.getPassive(identifier: "any-string-or-nonce")
{
case .success(let token):
    authenticateWithTokenString(token.token)
case .failure(let error):
    handleOrPresentError(error)
}
```

That token string can then be sent as a header or part of body payload (whatever works with your API endpoint) and will enable the server to call our secure endpoint to verify the humanDetect and return the details to your API.
