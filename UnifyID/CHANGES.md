# UnifyID iOS Core SDK Changes

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This file tracks the "Core" versioning information, relating to fixes that apply to all modules.
See individual module change logs for versioning information regarding modules.

## [4.7.6] 2022-02-14

### Changed

- Fix for passcode verification prompt while retrieving keychain items

## [4.7.5] 2021-12-21

### Added

- Support for Device Context collection

## [4.7.4] 2021-12-07

### Added

- Support for Xcode 13.0

## [4.7.3] 2021-06-02

### Changed

- Internal changes to support caching authentication and configuration state.
  This helps avoid redundant network calls when restarting the SDK after
  a short period of being inactive.
- Reduced the size of the bundled SwiftProtobuf framework.

## [4.7.0] - UNRELEASED

### Changed

- Internal changes to support BehaviorPrint SDK.

## [4.6.0] - UNRELEASED

### Changed

- Internal changes to support BehaviorPrint SDK.

## [4.5.0] - 2021-02-17

### Changed

- Internal changes to support BehaviorPrint SDK.

## [4.4.0] - 2020-10-13

### Changed

- Internal changes to support GaitAuth `4.4.0`

## [4.3.0] - 2020-09-30

### Added

- Support for Xcode 12.0

### Changed

- CocoaPod distribution changes. SDK is now distributed as
  `xcframework` bundles and requires `CocoaPods >= 1.10.0.rc.1`.
- Support GaitAuth 4.3.0, PushAuth 3.2.0, HumanDetect 3.2.0

## [4.2.1] - 2020-09-14

### Changed

- Support GaitAuth 4.2.1

## [4.2.0] - 2020-09-01

### Changed

- Support GaitAuth 4.2.0

## [4.1.0] - 2020-08-26

### Changed

- Exposed version numbers as static properties of each module class

## Fixed

- Fixed a bug causing a deadlock when trying to perform SDK initialization concurrently
- Suppress debug logging

## [4.0.0] - 2020-08-20

### Changed

- Support GaitAuth `4.0.0`

## [3.0.0] - Unreleased

### Changed

- Removed and renamed several error codes

## [2.0.27] - 2020-06-11

### Changed

- Support for changes in PushAuth 2.0.12
- Exposed an `installID` value for debugging
- Added `FileBackupBuffer` class to help with storing and acting on data
- Added `UnifyID.options` for updating optional SDK Configurations relating to diagnostics

## [2.0.24] - 2020-04-27

- First release of PushAuth module.
- Fix for a crash if SDK Key is entered incorrectly
- Documentation

## [2.0.23] - 2020-04-22

### Changed

- Documentation fixes
- Podspec URL change, using Github release rather than AWS for binary storage

## [2.0.22] - 2020-04-15

### Changed

- First official release.  HumanDetect module only.
