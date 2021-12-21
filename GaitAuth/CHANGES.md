# GaitAuth Changes

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This file tracks the GaitAuth module related changes.

## [4.4.7] - 2021-12-21

### Changed

- Upgrade to SDK Core 4.7.5
- Added new test API to Analytics to label user as an attacker
- Added new API to Analytics to allow host app submitting log messages to Prove for debugging and analytics purposes

## [4.4.6] - 2021-12-07

### Changed

- Upgrade to SDK Core 4.7.4
- Additional internal improvements to reporting SDK and application level events

## [4.4.5] - 2021-06-30

### Changed

- Upgrade to SDK Core 4.7.3

## [4.4.4] - 2021-06-02

### Changed

- Upgrade SDK Core to `4.7.2`

### Added

- Added experimental `loadMockModel` interface to facilitate testing GaitAuth models without training.

## [4.4.1] - 2021-02-17

### Changed

- Upgrade SDK Core to `4.5.0`

## [4.4.0] - 2020-10-13

### Changed

- Additional internal improvements in handling scores produced by Gait Authentictors.
- Distributed `UnifyIDUtilsSeer` as a `xcframework` instead of a fat `framework` file in
  order to support direct linking of the GaitAuth SDK.

### Fixed

- Bug where the GaitAuthenticator object did not successfully unsubscribe from feature
  updates when the instance was deinitialized.

## [4.3.0] - 2020-09-30

### Added

- Support for Xcode 12.0
- Experimental: Add additional `context` fields to result of `Authenticator`
  objects.

### Changed

- CocoaPod distribution changes. SDK is now distributed as
  `xcframework` bundles and requires `CocoaPods >= 1.10.0.rc.1`.

### Fixed

- Bug where device authenticator always returned
  inconclusive until the next lock/unlock event after initialization.
- Bug where gait authenticator would stop collecting data when reaching
  the configured maximum buffer size instead of discarding old data.

## [4.2.1] - 2020-09-14

### Added

- Experimental interface for extracting features from pre-recorded data

## [4.2.0] - 2020-09-01

### Added

- Experimental `Authenticator` interfaces
- Can now unsubscribe a single feature observer from updates

## [4.1.0] - 2020-08-26

## Added

- Exposed version numbers as static properties of each module class

### Changed

- Upgrade SDK Core to 4.1.0

## [4.0.0] - 2020-08-20

### Added

- New `GaitAuthError` case `.networkResponseInvalid`

### Changed

- `GaitScore` is now a struct instead of a protocol

### Removed

- Removed two unused cases in `GaitAuthError`

## [3.0.0] - 2020-08-11

### Changed

- Major set of breaking changes to public interface.
- GaitAuth now takes takes responsibility for local model storage.

## 2.0.0

### Added

- Initial trusted customer release
