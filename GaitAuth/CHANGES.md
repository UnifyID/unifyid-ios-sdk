# GaitAuth Changes

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This file tracks the GaitAuth module related changes.

## [4.2.0] - 2020-09-01

## Changes

- Added new experimental `Authenticator` interfaces
- Added the ability to unsubscribe a single feature observer from updates

## [4.1.0] - 2020-08-26

## Changes

- Exposed version numbers as static properties of each module class
- Upgrade SDK Core to 4.1.0

## [4.0.0] - 2020-08-20

## Changed

- `GaitScore` is now a struct instead of a protocol
- Removed two unused cases in `GaitAuthError`
- Added a new `GaitAuth.networkResponseInvalid` case

## [3.0.0] - 2020-08-11

## Changed

- Major set of breaking changes to public interface.
- GaitAuth now takes takes responsibility for local model storage.

## 2.0.0

Initial trusted customer release