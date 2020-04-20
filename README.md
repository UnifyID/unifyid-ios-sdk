# Get Started with UnifyID iOS SDK

## Prerequisites

- Swift 4.2 or greater
- iOS 10.0 or greater

## Initialize Cocoapods

UnifyID SDK is installed through cocoapods, if you haven't already you'll need to [setup your project to use cocoapods](https://guides.cocoapods.org/using/getting%2dstarted.html).

1. `sudo gem install cocoapods`
2. `pod init`

## Add the UnifyID SDK Cocoapod

1. Add `pod 'UnifyID'` to your `Podfile`
2. Run `pod install`
3. Open your project *using the workspace file*

## Obtain a Mobile SDK Key

Signup on the [UnifyID Developer Portal](https://developer.unify.id) to obtain a free SDK Key.

## Initialize an instance of UnifyID SDK

In your root object or app delegate initialize an instance of the sdk using `UnifyID.init(...)`.  You will need to provide your SDK key (looks like `https://xxxx@xxx.unify.id`), and a unique user identifier.  If you don't provide a user identifier one will be generated for you from the device ID.

> NOTE: User identifier is stored on Unify servers and should not contain email addresses or other personally identifying information

```swift
import UnifyID

let unify : UnifyID = { try! UnifyID(
    sdkKey: "https://xxx@yyy.unify.id",
    user: "unique-user-identifier-no-pii"
) }()
```

## Next Steps

### [Getting Started with HumanDetect](./HumanDetect.md)
