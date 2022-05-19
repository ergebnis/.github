# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

For a full diff see [`1.4.1...main`][1.4.1...main].

### Fixed

- Required a value for the `working-directory` input of the composite action `composer/determine-cache-directory` ([#82]), by [@localheinz]

## [`1.4.1`][1.4.1]

For a full diff see [`1.4.0...1.4.1`][1.4.0...1.4.1].

### Fixed

- Captured response in the composite action `github/release/create` ([#82]), by [@localheinz]

## [`1.4.0`][1.4.0]

For a full diff see [`1.3.2...1.4.0`][1.3.2...1.4.0].

### Changed

- Updated `actions/github-script` ([#79]), by [@localheinz]
- Started exposing `RELEASE_ID` and `RELEASE_UPLOAD_URL` environment variable in the composite action `github/release/create` ([#80]), by [@localheinz]

## [`1.3.2`][1.3.2]

For a full diff see [`1.3.1...1.3.2`][1.3.1...1.3.2].

### Fixed

- Fixed a condition ([#76]), by [@localheinz]

## [`1.3.1`][1.3.1]

For a full diff see [`1.3.0...1.3.1`][1.3.0...1.3.1].

## [`1.3.0`][1.3.0]

For a full diff see [`1.2.1...1.3.0`][1.2.1...1.3.0].

### Added

- Added composite action `github/pull-request/add-assignee` ([#59]), by [@localheinz]
- Added composite action `github/pull-request/approve` ([#60]), by [@localheinz]
- Added composite action `github/pull-request/merge` ([#64]), by [@localheinz]
- Added composite action `github/pull-request/add-label-based-on-branch-name` ([#67]), by [@localheinz]
- Added composite action `github/release/create` ([#72]), by [@localheinz]
- Added composite action `github/pull-request/request-review` ([#73]), by [@localheinz]

## [`1.2.1`][1.2.1]

For a full diff see [`1.2.0...1.2.1`][1.2.0...1.2.1].

### Fixed

- Added missing dash when specifying `working-dir` option ([#54]), by [@localheinz]

## [`1.2.0`][1.2.0]

For a full diff see [`1.1.0...1.2.0`][1.1.0...1.2.0].

### Added

- Added a `working-directory` input for the `composer/determine-cache-directory` action ([#52]), by [@localheinz]

## [`1.1.0`][1.1.0]

For a full diff see [`1.0.0...1.1.0`][1.0.0...1.1.0].

### Added

- Added a `working-directory` input for the `composer/install` action ([#49]), by [@localheinz]

## [`1.0.0`][1.0.0]

For a full diff see [`1.0.0...main`][1.0.0...main].

### Added

- Added composite actions for determining the `composer` cache directory and installing dependencies with `composer` ([#47]), by [@localheinz]

[1.0.0]: https://github.com/ergebnis/.github/releases/tag/1.0.0
[1.1.0]: https://github.com/ergebnis/.github/releases/tag/1.1.0
[1.2.0]: https://github.com/ergebnis/.github/releases/tag/1.2.0
[1.2.1]: https://github.com/ergebnis/.github/releases/tag/1.2.1
[1.3.0]: https://github.com/ergebnis/.github/releases/tag/1.3.0
[1.3.1]: https://github.com/ergebnis/.github/releases/tag/1.3.1
[1.3.2]: https://github.com/ergebnis/.github/releases/tag/1.3.2
[1.4.0]: https://github.com/ergebnis/.github/releases/tag/1.4.0

[ca7f15d...1.0.0]: https://github.com/ergebnis/.github/compare/ca7f15d...1.0.0
[1.0.0...1.1.0]: https://github.com/ergebnis/.github/compare/1.0.0...1.1.0
[1.1.0...1.2.0]: https://github.com/ergebnis/.github/compare/1.1.0...1.2.0
[1.2.0...1.2.1]: https://github.com/ergebnis/.github/compare/1.2.0...1.2.1
[1.2.1...1.3.0]: https://github.com/ergebnis/.github/compare/1.2.1...1.3.0
[1.3.0...1.3.1]: https://github.com/ergebnis/.github/compare/1.3.0...1.3.1
[1.3.1...1.3.2]: https://github.com/ergebnis/.github/compare/1.3.1...1.3.2
[1.3.2...1.4.0]: https://github.com/ergebnis/.github/compare/1.3.2...1.4.0
[1.4.0...1.4.1]: https://github.com/ergebnis/.github/compare/1.4.0...1.4.1
[1.4.1...main]: https://github.com/ergebnis/.github/compare/1.4.1...main

[#47]: https://github.com/ergebnis/.github/pull/47
[#48]: https://github.com/ergebnis/.github/pull/48
[#52]: https://github.com/ergebnis/.github/pull/52
[#54]: https://github.com/ergebnis/.github/pull/54
[#59]: https://github.com/ergebnis/.github/pull/59
[#60]: https://github.com/ergebnis/.github/pull/60
[#64]: https://github.com/ergebnis/.github/pull/64
[#67]: https://github.com/ergebnis/.github/pull/67
[#72]: https://github.com/ergebnis/.github/pull/72
[#73]: https://github.com/ergebnis/.github/pull/73
[#76]: https://github.com/ergebnis/.github/pull/76
[#79]: https://github.com/ergebnis/.github/pull/79
[#80]: https://github.com/ergebnis/.github/pull/80
[#82]: https://github.com/ergebnis/.github/pull/82

[@localheinz]: https://github.com/localheinz
