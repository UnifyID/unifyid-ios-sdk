# UnifyID iOS SDK Reference

## Prerequisites

- Swift `5.1` or greater
- iOS `10.0` or greater
- Xcode `11.6` or greater
- CocoaPods `1.10.0.rc.1` or greater.

## Next Steps

Follow one of our guides on our [developer portal](https://developer.unify.id/docs/).

## Installation

### CocoaPods

CocoaPods `1.10.0.rc.1` or greater is now required. In order to support Xcode 12 and up,
the SDK is now packaged as `xcframework` binaries. Only CocoaPods `1.10.0` and greater
have support for this version of Xcode and for `xcframework` files.

To upgrade CocoaPods, update the version in your `Gemfile` and then run `bundle update`

```ruby
gem 'cocoapods', '~> 1.10.0.rc.1'
```

Or upgrade your system installation of CocoaPods if you do not use Bundler.

```shell
# with sudo if using system ruby
gem install cocoapods --pre
```

### Setting up CocoaPods

Add the UnifyID pod to your app target.

```ruby
platform :ios, '10.0'

target 'MyApp' do
  use_frameworks!
  pod 'UnifyID/GaitAuth'
end
```
