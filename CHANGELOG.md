# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

For a full diff see [`1.2.1...main`][1.2.1...main].

### Added

- Added composite action `github/pull-request/add-assignee` ([#59]), by [@localheinz]
- Added composite action `github/pull-request/approve` ([#60]), by [@localheinz]
- Added composite action `github/pull-request/merge` ([#64]), by [@localheinz]
- Added composite action `github/pull-request/add-label-based-on-branch-name` ([#67]), by [@localheinz]

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

[ca7f15d...1.0.0]: https://github.com/ergebnis/.github/compare/ca7f15d...1.0.0
[1.0.0...1.1.0]: https://github.com/ergebnis/.github/compare/1.0.0...1.1.0
[1.1.0...1.2.0]: https://github.com/ergebnis/.github/compare/1.1.0...1.2.0
[1.2.0...1.2.1]: https://github.com/ergebnis/.github/compare/1.2.0...1.2.1
[1.2.1...main]: https://github.com/ergebnis/.github/compare/1.2.1...main

[#47]: https://github.com/ergebnis/.github/pull/47
[#48]: https://github.com/ergebnis/.github/pull/48
[#52]: https://github.com/ergebnis/.github/pull/52
[#54]: https://github.com/ergebnis/.github/pull/54
[#59]: https://github.com/ergebnis/.github/pull/59
[#60]: https://github.com/ergebnis/.github/pull/60
[#64]: https://github.com/ergebnis/.github/pull/64
[#67]: https://github.com/ergebnis/.github/pull/67

[@localheinz]: https://github.com/localheinz
