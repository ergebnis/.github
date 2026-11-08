# .github

[![Integrate](https://github.com/ergebnis/.github/workflows/Integrate/badge.svg)](https://github.com/ergebnis/.github/actions)
[![Merge](https://github.com/ergebnis/.github/workflows/Merge/badge.svg)](https://github.com/ergebnis/.github/actions)
[![Release](https://github.com/ergebnis/.github/workflows/Release/badge.svg)](https://github.com/ergebnis/.github/actions)

This project provides [community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file) and [composite actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) for the [@ergebnis](https://github.com/ergebnis) organization.

## Composite Actions

<!-- BEGIN ACTIONS -->

This project provides the following composite actions:

- [`ergebnis/.github/actions/composer/determine-cache-directory`](#composer-determine-cache-directory)
- [`ergebnis/.github/actions/composer/determine-root-version`](#composer-determine-root-version)
- [`ergebnis/.github/actions/composer/install`](#composer-install)
- [`ergebnis/.github/actions/github/pull-request/add-assignee`](#github-pull-request-add-assignee)
- [`ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`](#github-pull-request-add-label-based-on-branch-name)
- [`ergebnis/.github/actions/github/pull-request/approve`](#github-pull-request-approve)
- [`ergebnis/.github/actions/github/pull-request/enable-auto-merge`](#github-pull-request-enable-auto-merge)
- [`ergebnis/.github/actions/github/pull-request/merge`](#github-pull-request-merge)
- [`ergebnis/.github/actions/github/pull-request/request-review`](#github-pull-request-request-review)
- [`ergebnis/.github/actions/github/release/create`](#github-release-create)
- [`ergebnis/.github/actions/github/release/publish`](#github-release-publish)
- [`ergebnis/.github/actions/oh-dear/check/request-run`](#oh-dear-check-request-run)
- [`ergebnis/.github/actions/oh-dear/maintenance-period/start`](#oh-dear-maintenance-period-start)
- [`ergebnis/.github/actions/oh-dear/maintenance-period/stop`](#oh-dear-maintenance-period-stop)
- [`ergebnis/.github/actions/phive/install`](#phive-install)
- [`ergebnis/.github/actions/sentry/cli/install`](#sentry-cli-install)
- [`ergebnis/.github/actions/sentry/release/create`](#sentry-release-create)

### <a name="composer-determine-cache-directory"> `ergebnis/.github/actions/composer/determine-cache-directory`

This action determines the cache directory for [`composer`](https://github.com/composer/composer) and exports it as [`COMPOSER_CACHE_DIR`](https://getcomposer.org/doc/03-cli.md#composer-cache-dir) environment variable.

This is useful for caching dependencies installed with `composer` using [`actions/cache`](https://github.com/actions/cache).

💡 Find out more in the documentation for [`ergebnis/.github/actions/composer/determine-cache-directory`](actions/composer/determine-cache-directory/README.md).

### <a name="composer-determine-root-version"> `ergebnis/.github/actions/composer/determine-root-version`

This action determines the composer root version and exports it as [`COMPOSER_ROOT_VERSION`](https://getcomposer.org/doc/03-cli.md#composer-root-version) environment variable.

This is useful for a package that depends on itself, for example, [`phpunit/phpunit`](https://github.com/sebastianbergmann/phpunit/blob/802b91a979fb79f39ac8f87def3996913a7fef11/.github/workflows/ci.yml#L9-L10)

💡 Find out more in the documentation for [`ergebnis/.github/actions/composer/determine-root-version`](actions/composer/determine-root-version/README.md).

### <a name="composer-install"> `ergebnis/.github/actions/composer/install`

This action installs or updates dependencies with [`composer`](https://getcomposer.org/doc/03-cli.md#install-i).

💡 Find out more in the documentation for [`ergebnis/.github/actions/composer/install`](actions/composer/install/README.md).

### <a name="github-pull-request-add-assignee"> `ergebnis/.github/actions/github/pull-request/add-assignee`

This action adds an assignee to a pull request.

This is useful when you want to automatically merge a pull request, but prefer to assign a bot user beforehand.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/add-assignee`](actions/github/pull-request/add-assignee/README.md).

### <a name="github-pull-request-add-label-based-on-branch-name"> `ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`

This action adds a label to a pull request based on the name of the branch.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`](actions/github/pull-request/add-label-based-on-branch-name/README.md).

### <a name="github-pull-request-approve"> `ergebnis/.github/actions/github/pull-request/approve`

This action approves a pull request.

This is useful when you want to automatically merge a pull request, but prefer to let a bot user approve the pull request beforehand.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/approve`](actions/github/pull-request/approve/README.md).

### <a name="github-pull-request-enable-auto-merge"> `ergebnis/.github/actions/github/pull-request/enable-auto-merge`

This action enables auto-merge for a pull request.

This is useful when you want to automatically merge pull requests, for example, opened by [`dependabot`](https://github.com/dependabot), and let GitHub merge them one after another. When several pull requests are merged directly at the same time, GitHub rejects all but the first with `Base branch was modified`.

Enable auto-merge before approving the pull request: GitHub refuses to enable auto-merge for a pull request that can already be merged.

This action requires the repository to [allow auto-merge](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-auto-merge-for-pull-requests-in-your-repository), otherwise GitHub refuses to enable auto-merge and the step fails.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/enable-auto-merge`](actions/github/pull-request/enable-auto-merge/README.md).

### <a name="github-pull-request-merge"> `ergebnis/.github/actions/github/pull-request/merge`

This action merges a pull request.

This is useful when you want to automatically merge a pull request, for example, opened by [`dependabot`](https://github.com/dependabot).

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/merge`](actions/github/pull-request/merge/README.md).

### <a name="github-pull-request-request-review"> `ergebnis/.github/actions/github/pull-request/request-review`

This action requests a review for a pull request.

This is useful when you want to automatically merge a pull request, but prefer to let a bot user self-request a review for the pull request beforehand.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/pull-request/request-review`](actions/github/pull-request/request-review/README.md).

### <a name="github-release-create"> `ergebnis/.github/actions/github/release/create`

This action creates a release.

This is useful when you automatically want to create releases with [automatically generated release notes](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes).

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/release/create`](actions/github/release/create/README.md).

### <a name="github-release-publish"> `ergebnis/.github/actions/github/release/publish`

This action publishes a release.

This is useful when you want to publish a release created in draft mode.

💡 Find out more in the documentation for [`ergebnis/.github/actions/github/release/publish`](actions/github/release/publish/README.md).

### <a name="oh-dear-check-request-run"> `ergebnis/.github/actions/oh-dear/check/request-run`

This action requests a [check](https://ohdear.app/docs/general/checks) run on [Oh Dear!](https://ohdear.app).

💡 Find out more in the documentation for [`ergebnis/.github/actions/oh-dear/check/request-run`](actions/oh-dear/check/request-run/README.md).

### <a name="oh-dear-maintenance-period-start"> `ergebnis/.github/actions/oh-dear/maintenance-period/start`

This action starts a [maintenance period](https://ohdear.app/docs/general/maintenance-windows) on [Oh Dear!](https://ohdear.app).

💡 Find out more in the documentation for [`ergebnis/.github/actions/oh-dear/maintenance-period/start`](actions/oh-dear/maintenance-period/start/README.md).

### <a name="oh-dear-maintenance-period-stop"> `ergebnis/.github/actions/oh-dear/maintenance-period/stop`

This action stops a [maintenance period](https://ohdear.app/docs/general/maintenance-windows) on [Oh Dear!](https://ohdear.app).

💡 Find out more in the documentation for [`ergebnis/.github/actions/oh-dear/maintenance-period/stop`](actions/oh-dear/maintenance-period/stop/README.md).

### <a name="phive-install"> `ergebnis/.github/actions/phive/install`

This action installs dependencies with [`phive`](https://phar.io).

💡 Find out more in the documentation for [`ergebnis/.github/actions/phive/install`](actions/phive/install/README.md).

### <a name="sentry-cli-install"> `ergebnis/.github/actions/sentry/cli/install`

This action installs [`sentry-cli`](https://github.com/getsentry/sentry-cli).

💡 Find out more in the documentation for [`ergebnis/.github/actions/sentry/cli/install`](actions/sentry/cli/install/README.md).

### <a name="sentry-release-create"> `ergebnis/.github/actions/sentry/release/create`

This action creates a [release](https://docs.sentry.io/product/releases/) on [Sentry](https://sentry.io) with [`sentry-cli`](https://github.com/getsentry/sentry-cli), associates commits with it, finalizes it, and records a deploy.

💡 Find out more in the documentation for [`ergebnis/.github/actions/sentry/release/create`](actions/sentry/release/create/README.md).

<!-- END ACTIONS -->

## Changelog

The maintainers of this project record notable changes to this project in a [changelog](CHANGELOG.md).

## Contributing

The maintainers of this project suggest following the [contribution guide](.github/CONTRIBUTING.md).

## Code of Conduct

The maintainers of this project ask contributors to follow the [code of conduct](CODE_OF_CONDUCT.md).

## General Support Policy

The maintainers of this project provide limited support.

## Security Policy

This project has a [security policy](.github/SECURITY.md).

## License

This project uses the [MIT license](LICENSE.md).

## Social

Follow [@localheinz](https://twitter.com/intent/follow?screen_name=localheinz) and [@ergebnis](https://twitter.com/intent/follow?screen_name=ergebnis) on Twitter.
