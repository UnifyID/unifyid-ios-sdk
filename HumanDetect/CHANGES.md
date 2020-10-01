# HumanDetect Changes

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This file tracks the GaitAuth module related changes.

## [3.2.0] - 2020-09-30

### Added

- Support for Xcode 12.0

### Changed

- CocoaPod distribution changes. SDK is now distributed as
  `xcframework` bundles and requires `CocoaPods >= 1.10.0.rc.1`.

## [3.1.2] - 2020-09-14

### Changed

- Upgrade SDK Core to 4.2.1

## [3.1.1] - 2020-09-01

### Changed

- Upgrade SDK Core to 4.2.0

## [3.1.0] - 2020-08-26

### Changed

- Exposed version numbers as static properties of each module class
- Upgrade SDK Core to 4.1.0

## [3.0.0] - 2020-08-20

### Changed

- Removed `HumanDetectError.doNotDirectlyInitialize`
- Removed `HumanDetect.init()` to enforce requirement of initializing with `UnifyID.humanDetect`

## [2.0.4] - 2020-06-11

No tracked changes

## [2.0.3] - 2020-05-14

- Updated for compatibility with latest core release

## [2.0.2] - 2020-04-27

### Added

- Initial Release of HumanDetect Module
