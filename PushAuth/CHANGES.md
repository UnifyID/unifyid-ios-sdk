# PushAuth Changes

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This file tracks the PushAuth module related changes.

## [3.2.6] - 2021-06-30

### Changed

- Upgrade to SDK Core 4.7.3

## [3.2.5] - 2021-06-02

### Changed

- Upgrade SDK Core to `4.7.2`

## [3.2.4] - UNRELEASED

### Changed

- Upgrade SDK Core to `4.7.1`

## [3.2.3] - UNRELEASED

### Changed

- Upgrade SDK Core to `4.6.0`

## [3.2.2] - 2021-02-17

### Changed

- Upgrade SDK Core to `4.5.0`

## [3.2.1] - 2020-10-13

### Changed

- Upgrade SDK Core to `4.4.0`

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

### Added

- Exposed version numbers as static properties of each module class

### Changed

- Upgrade SDK Core to 4.1.0

## [3.0.0] - 2020-08-20

### Added

- Introduced `PushAuth.deregister(:)` call to stop receiving PushAuth notifications.

### Removed

- `PushAuthError` case `.doNotDirectlyInitialize`
- `PushAuth.init()` method

## [2.0.13] - 2020-06-11

### Changed

- If user was not set on SDK initialized will now throw an error
- Fix issue around first registration occurring during app background

## [2.0.11] - 2020-06-10

### Added

- Initial Public Release
