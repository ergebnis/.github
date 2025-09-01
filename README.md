# .github

[![Integrate](https://github.com/ergebnis/.github/workflows/Integrate/badge.svg)](https://github.com/ergebnis/.github/actions)
[![Merge](https://github.com/ergebnis/.github/workflows/Merge/badge.svg)](https://github.com/ergebnis/.github/actions)
[![Release](https://github.com/ergebnis/.github/workflows/Release/badge.svg)](https://github.com/ergebnis/.github/actions)

This project provides [community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file) and [composite actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) for the [@ergebnis](https://github.com/ergebnis) organization.

## Composite Actions

This project provides the following composite actions:

- [`ergebnis/.github/actions/composer/determine-cache-directory`](#composer-determine-cache-directory)
- [`ergebnis/.github/actions/composer/determine-root-version`](#composer-determine-root-version)
- [`ergebnis/.github/actions/composer/install`](#composer-install)
- [`ergebnis/.github/actions/github/pull-request/add-assignee`](#github-pull-request-add-assignee)
- [`ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`](#github-pull-request-add-label-based-on-branch-name)
- [`ergebnis/.github/actions/github/pull-request/approve`](#github-pull-request-approve)
- [`ergebnis/.github/actions/github/pull-request/merge`](#github-pull-request-merge)
- [`ergebnis/.github/actions/github/pull-request/request-review`](#github-pull-request-review)
- [`ergebnis/.github/actions/github/release/create`](#github-release-create)
- [`ergebnis/.github/actions/oh-dear/check/request-run`](#oh-dear-check-request-run)
- [`ergebnis/.github/actions/oh-dear/maintenance-period/start`](#oh-dear-maintenance-period-start)
- [`ergebnis/.github/actions/oh-dear/maintenance-period/stop`](#oh-dear-maintenance-period-stop)
- [`ergebnis/.github/actions/phive/install`](#phive-install)

### <a name="composer-determine-cache-directory"> `ergebnis/.github/actions/composer/determine-cache-directory`

This action determines the cache directory for [`composer`](https://github.com/composer/composer) and exports it as [`COMPOSER_CACHE_DIR`](https://getcomposer.org/doc/03-cli.md#composer-cache-dir) environment variable.

This is useful for caching dependencies installed with `composer` using [`actions/cache`](https://github.com/actions/cache).

```yaml
name: "Integrate"

on:
  pull_request: null
  push:
    branches:
      - "main"

jobs:
  tests:
    name: "Tests"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Checkout"
        uses: "actions/checkout@v3.0.2"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.21.2"
        with:
          coverage: "none"
          php-version: "8.1"

      - name: "Determine composer cache directory"
        uses: "ergebnis/.github/actions/composer/determine-cache-directory@1.8.0"

      - name: "Cache dependencies installed with composer"
        uses: "actions/cache@v3.0.8"
        with:
          path: "${{ env.COMPOSER_CACHE_DIR }}"
          key: "composer-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-"
```

For details, see [`actions/composer/determine-cache-directory/action.yaml`](actions/composer/determine-cache-directory/action.yaml).

#### Inputs

- `working-directory`, optional: The working directory to use. Defaults to `"."`.

#### Outputs

none

#### Side Effects

- The `COMPOSER_CACHE_DIR` environment variable contains the path to the composer cache directory.

### <a name="composer-determine-root-version"> `ergebnis/.github/actions/composer/determine-root-version`

This action determines the composer root version and exports it as [`COMPOSER_ROOT_VERSION`](https://getcomposer.org/doc/03-cli.md#composer-root-version) environment variable.

This is useful for a package that depends on itself, for example, [`phpunit/phpunit`](https://github.com/sebastianbergmann/phpunit/blob/802b91a979fb79f39ac8f87def3996913a7fef11/.github/workflows/ci.yml#L9-L10)

```yaml
name: "Integrate"

on:
  pull_request: null
  push:
    branches:
      - "main"

jobs:
  tests:
    name: "Tests"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Checkout"
        uses: "actions/checkout@v3.0.2"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.21.2"
        with:
          coverage: "none"
          php-version: "8.1"

      - name: "Determine composer root version"
        uses: "ergebnis/.github/actions/composer/determine-root-version@1.8.0"
```

For details, see [`actions/composer/determine-root-version/action.yaml`](actions/composer/determine-root-version/action.yaml).

#### Inputs

- `branch`, optional: The name of the branch, defaults to `"main"`.
- `working-directory`, optional: The working directory to use, defaults to `"."`.

#### Outputs

none

#### Side Effects

- The `COMPOSER_ROOT_VERSION` environment variable contains the root version if it has been defined as `branch-alias` in `composer.json`.

  ```json
  {
    "extra": {
      "branch-alias": {
        "dev-main": "10.0-dev"
      }
    }
  }
  ```

### <a name="composer-install"> `ergebnis/.github/actions/composer/install`

This action installs or updates dependencies with [`composer`](https://getcomposer.org/doc/03-cli.md#install-i).

```yaml
name: "Integrate"

on:
  pull_request: null
  push:
    branches:
      - "main"

jobs:
  tests:
    name: "Tests"

    runs-on: "ubuntu-latest"

    strategy:
      matrix:
        dependencies:
          - "lowest"
          - "locked"
          - "highest"

    steps:
      - name: "Checkout"
        uses: "actions/checkout@v3.0.2"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.21.2"
        with:
          coverage: "none"
          php-version: "8.1"

      - name: "Determine composer cache directory"
        uses: "ergebnis/.github/actions/composer/determine-cache-directory@1.8.0"

      - name: "Cache dependencies installed with composer"
        uses: "actions/cache@v3.0.8"
        with:
          path: "${{ env.COMPOSER_CACHE_DIR }}"
          key: "composer-${{ matrix.dependencies }}-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-${{ matrix.dependencies }}-"

      - name: "Install ${{ matrix.dependencies }} dependencies with composer"
        uses: "ergebnis/.github/actions/composer/install@1.8.0"
        with:
          dependencies: "${{ matrix.dependencies }}"
```

For details, see [`actions/composer/install/action.yaml`](actions/composer/install/action.yaml).

#### Inputs

- `dependencies`, optional: Which dependencies to install, one of `"lowest"`, `"locked"`, `"highest"`
- `working-directory`, optional: The working directory to use, defaults to `"."`.

#### Outputs

none

#### Side Effects

- When `dependencies` is set to `"lowest"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer update --ansi --no-interaction --no-progress --prefer-lowest
  ````
- When `dependencies` is set to `"locked"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer install --ansi --no-interaction --no-progress
  ```

- When `dependencies` is set to `"highest"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer update --ansi --no-interaction --no-progress
  ````

### <a name="github-pull-request-add-assignee"> `ergebnis/.github/actions/github/pull-request/add-assignee`

This action adds an assignee to a pull request.

This is useful when you want to automatically merge a pull request, but prefer to assign a bot user beforehand.

```yaml
name: "Merge"

on:
  workflow_run:
    types:
      - "completed"
    workflows:
      - "Integrate"

jobs:
  merge:
    name: "Merge"

    runs-on: "ubuntu-latest"

    if: >
      github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' &&
      github.actor == 'dependabot[bot]' && (
        startsWith(github.event.workflow_run.head_commit.message, 'composer(deps-dev)') ||
        startsWith(github.event.workflow_run.head_commit.message, 'github-actions(deps)')
      )

    steps:
      - name: "Assign @ergebnis-bot"
        uses: "ergebnis/.github/actions/github/pull-request/add-assignee@1.8.0"
        with:
          assignee: "ergebnis-bot"
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/pull-request/add-assignee/action.yaml`](actions/github/pull-request/add-assignee/action.yaml).

#### Inputs

- `assignee`, required: The username of a user to add as an assignee to a pull request.
- `github-token`, required: The GitHub token of a user with permission to add assignees to a pull request

#### Outputs

none

#### Side Effects

- The GitHub user with the username specified in the `assignee` input is assigned to the pull request.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.

### <a name="github-pull-request-add-label-based-on-branch-name"> `ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`

This action adds a label to a pull request based on the name of the branch.

```yaml
# https://docs.github.com/en/actions

name: "Triage"

on: # yamllint disable-line rule:truthy
  pull_request_target:
    types:
      - "opened"

jobs:
  label:
    name: "Label"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Add labels based on branch name"
        uses: "ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name@1.8.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/pull-request/add-label-based-on-branch-name/action.yaml`](actions/github/pull-request/add-label-based-on-branch-name/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to add labels to to a pull request.

#### Outputs

none

#### Side Effects

- When the branch name starts with `feature/`, the label `enhancement` is added to the pull request by the user who owns the GitHub token specified with the `github-token` input.
- When the branch name starts with `fix/`, the label `bug` is added to the pull request by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_BRANCH_NAME` environment variable contains the name of the head branch of the pull request.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.

### <a name="github-pull-request-approve"> `ergebnis/.github/actions/github/pull-request/approve`

This action approves a pull request.

This is useful when you want to automatically merge a pull request, but prefer to let a bot user approve the pull request beforehand.

```yaml
name: "Merge"

on:
  workflow_run:
    types:
      - "completed"
    workflows:
      - "Integrate"

jobs:
  merge:
    name: "Merge"

    runs-on: "ubuntu-latest"

    if: >
      github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' &&
      github.actor == 'dependabot[bot]' && (
        startsWith(github.event.workflow_run.head_commit.message, 'composer(deps-dev)') ||
        startsWith(github.event.workflow_run.head_commit.message, 'github-actions(deps)')
      )

    steps:
      - name: "Approve pull request"
        uses: "ergebnis/.github/actions/github/pull-request/approve@1.8.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/pull-request/merge/action.yaml`](actions/github/pull-request/merge/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to approve a pull request

#### Outputs

none

#### Side Effects

- The pull request is approved by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.

### <a name="github-pull-request-merge"> `ergebnis/.github/actions/github/pull-request/merge`

This action merges a pull request.

This is useful when you want to automatically merge a pull request, for example, opened by [`dependabot`](https://github.com/dependabot).

```yaml
name: "Merge"

on:
  workflow_run:
    types:
      - "completed"
    workflows:
      - "Integrate"

jobs:
  merge:
    name: "Merge"

    runs-on: "ubuntu-latest"

    if: >
      github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' &&
      github.actor == 'dependabot[bot]' && (
        startsWith(github.event.workflow_run.head_commit.message, 'composer(deps-dev)') ||
        startsWith(github.event.workflow_run.head_commit.message, 'github-actions(deps)')
      )

    steps:
      - name: "Merge pull request"
        uses: "ergebnis/.github/actions/github/pull-request/merge@1.8.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/pull-request/merge/action.yaml`](actions/github/pull-request/merge/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to merge a pull request
- `merge-method`, option: The merge method to use, one `"merge"`, `"rebase"`, `"squash"`, defaults to `"merge"`

#### Outputs

none

#### Side Effects

- The pull request is merged by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.

### <a name="github-pull-request-request-review"> `ergebnis/.github/actions/github/pull-request/request-review`

This action requests a review for a pull request.

This is useful when you want to automatically merge a pull request, but prefer to let a bot user self-request a review for the pull request beforehand.

```yaml
name: "Merge"

on:
  workflow_run:
    types:
      - "completed"
    workflows:
      - "Integrate"

jobs:
  merge:
    name: "Merge"

    runs-on: "ubuntu-latest"

    if: >
      github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' &&
      github.actor == 'dependabot[bot]' && (
        startsWith(github.event.workflow_run.head_commit.message, 'composer(deps-dev)') ||
        startsWith(github.event.workflow_run.head_commit.message, 'github-actions(deps)')
      )

    steps:
      - name: "Request review from @ergebnis-bot"
        uses: "ergebnis/.github/actions/github/pull-request/request-review@1.8.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
          reviewer: "ergebnis-bot"
```

For details, see [`actions/github/pull-request/request-review/action.yaml`](actions/github/pull-request/request-review/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to request reviewers for a pull request.
- `reviewer`, required: The username of user to request review from for a pull request.

#### Outputs

none

#### Side Effects

- A pull request review is requested for the user identified by the value of the `reviewer` input by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.

### <a name="github-release-create"> `ergebnis/.github/actions/github/release/create`

This action creates a release.

This is useful when you automatically want to create releases with [automatically generated release notes](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes).

```yaml

name: "Release"

on:
  push:
    tags:
      - "**"

jobs:
  release:
    name: "Release"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Create release"
        uses: "ergebnis/.github/actions/github/release/create@1.8.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/release/create/action.yaml`](actions/github/release/create/action.yaml).

#### Inputs

- `draft`, optional: Whether to create a draft or a published release.
- `github-token`, required: The GitHub token of a user with permission to create a release.

#### Outputs

none

#### Side Effects

- A release is created by the user who owns the GitHub token specified with the `github-token` input.
- The `RELEASE_HTML_URL` environment variable contains the HTML URL to the release.
- The `RELEASE_ID` environment variable contains the release identifier.
- The `RELEASE_TAG` environment variable contains the release tag.
- The `RELEASE_UPLOAD_URL` environment variable contains the URL for uploading release assets.
-
### <a name="github-release-publish"> `ergebnis/.github/actions/github/release/publish`

This action publishes a release.

This is useful when you want to publish a release created in draft mode.

```yaml

name: "Release"

on:
  push:
    tags:
      - "**"

jobs:
  release:
    name: "Release"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Publish release"
        uses: "ergebnis/.github/actions/github/release/publish@1.10.0"
        with:
          release-id: "9001"
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/release/publish/action.yaml`](actions/github/release/publish/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to create a release.
- `release-id`, required: The release identifier.

#### Outputs

none

#### Side Effects

- The release identified by the release identifier is published by the user who owns the GitHub token specified with the `github-token` input.

### <a name="oh-dear-check-request-run"> `ergebnis/.github/actions/oh-dear/check/request-run`

This action requests a [check](https://ohdear.app/docs/general/checks) run on [Oh Dear!](https://ohdear.app).

```yaml
name: "Deploy"

on:
  push:
    branches:
      - "main"

jobs:
  deploy:
    name: "Deploy"

    runs-on: "ubuntu-latest"

    steps:
    - name: "Checkout"
      uses: "actions/checkout@v3.0.2"
      with:
          fetch-depth: 50

    - name: "Request broken links check on ohdear.app"
      uses: "ergebnis/.github/actions/oh-dear/maintenance-period/start@1.8.0"
      with:
        oh-dear-api-token: "${{ secrets.OH_DEAR_API_TOKEN }}"
        oh-dear-check-id: "${{ secrets.OH_DEAR_BROKEN_LINKS_CHECK_ID }}"
```

For details, see [`actions/oh-dear/check/request-run/action.yaml`](actions/oh-dear/check/request-run/action.yaml).

#### Inputs

- `oh-dear-api-token`, required: The Oh Dear API token of a user with permission to request a check run
- `oh-dear-check-id`, required: Check identifer of an Oh Dear check for which to request a run

#### Outputs

none

#### Side Effects

- A check run is requested by the user who owns the Oh Dear API token specified with the `oh-dear-api-token` input for the check identified by the `oh-dear-check-id` input.

### <a name="oh-dear-maintenance-period-start"> `ergebnis/.github/actions/oh-dear/maintenance-period/start`

This action starts a [maintenance period](https://ohdear.app/docs/general/maintenance-windows) on [Oh Dear!](https://ohdear.app).

```yaml
name: "Deploy"

on:
  push:
    branches:
      - "main"

jobs:
  deploy:
    name: "Deploy"

    runs-on: "ubuntu-latest"

    steps:
    - name: "Checkout"
      uses: "actions/checkout@v3.0.2"
      with:
          fetch-depth: 50

    - name: "Start maintenance period on ohdear.app"
      uses: "ergebnis/.github/actions/oh-dear/maintenance-period/start@1.8.0"
      with:
        oh-dear-api-token: "${{ secrets.OH_DEAR_API_TOKEN }}"
        oh-dear-site-id: "${{ secrets.OH_DEAR_SITE_ID }}"
```

For details, see [`actions/oh-dear/maintenance-period/start/action.yaml`](actions/oh-dear/maintenance-period/start/action.yaml).

#### Inputs

- `oh-dear-api-token`, required: The Oh Dear API token of a user with permission to start a maintenance period
- `oh-dear-site-id`, required: Site identifer of an Oh Dear site for which to start a maintenance period

#### Outputs

none

#### Side Effects

- A maintenance period is started by the user who owns the Oh Dear API token specified with the `oh-dear-api-token` input for the site identified by the `oh-dear-site-id` input.

### <a name="oh-dear-maintenance-period-stop"> `ergebnis/.github/actions/oh-dear/maintenance-period/stop`

This action stops a [maintenance period](https://ohdear.app/docs/general/maintenance-windows) on [Oh Dear!](https://ohdear.app).

```yaml
name: "Deploy"

on:
  push:
    branches:
      - "main"

jobs:
  deploy:
    name: "Deploy"

    runs-on: "ubuntu-latest"

    steps:
    - name: "Checkout"
      uses: "actions/checkout@v3.0.2"
      with:
          fetch-depth: 50

    - name: "Stop maintenance period on ohdear.app"
      uses: "ergebnis/.github/actions/oh-dear/maintenance-period/stop@1.8.0"
      with:
        oh-dear-api-token: "${{ secrets.OH_DEAR_API_TOKEN }}"
        oh-dear-site-id: "${{ secrets.OH_DEAR_SITE_ID }}"
```

For details, see [`actions/oh-dear/maintenance-period/stop/action.yaml`](actions/oh-dear/maintenance-period/stop/action.yaml).

#### Inputs

- `oh-dear-api-token`, required: The Oh Dear API token of a user with permission to stop a maintenance period
- `oh-dear-site-id`, required: Site identifer of an Oh Dear site for which to stop a maintenance period

#### Outputs

none

#### Side Effects

- A maintenance period is stopped by the user who owns the Oh Dear API token specified with the `oh-dear-api-token` input for the site identified by the `oh-dear-site-id` input.

### <a name="phive-install"> `ergebnis/.github/actions/phive/install`

This action installs dependencies with [`phive`](https://phar.io).

```yaml
name: "Integrate"

on:
  pull_request: null
  push:
    branches:
      - "main"

jobs:
  tests:
    name: "Tests"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Checkout"
        uses: "actions/checkout@v3.0.2"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.21.2"
        with:
          coverage: "none"
          php-version: "8.1"
          tools: "phive"

      - name: "Install dependencies with phive"
        uses: "ergebnis/.github/actions/phive/install@1.8.0"
        with:
          trust-gpg-keys: "0x033E5F8D801A2F8D,0x2A8299CE842DD38C"
```

For details, see [`actions/phive/install/action.yaml`](actions/phive/install/action.yaml).

#### Inputs

- `phive-home`, optional: Which directory to use as `PHIVE_HOME` directory, defaults to `".build/phive"`.
- `trust-gpg-keys`, required: Which GPG keys to trust, a comma-separated list of trusted GPG keys

#### Outputs

none

#### Side Effects

- Given that `phive` is available, `phive` could find a `phars.xml`, and keys presented by packages are listed using the `trust-gpg-keys` option, dependencies are installed with `phive`.

The directory configured by the `phive-home` directory is cached using [`actions/cache`](https://github.com/actions/cache).

## Changelog

The maintainers of this project record notable changes to this project in a [changelog](CHANGELOG.md).

## Contributing

The maintainers of this project suggest following the [contribution guide](.github/CONTRIBUTING.md).

## Code of Conduct

The maintainers of this project ask contributors to follow the [code of conduct](CODE_OF_CONDUCT.md).

## General Support Policy

The maintainers of this project provide limited support.

You can support the maintenance of this project by [sponsoring @ergebnis](https://github.com/sponsors/ergebnis).

## Security Policy

This project has a [security policy](.github/SECURITY.md).

## License

This project uses the [MIT license](LICENSE.md).

## Social

Follow [@localheinz](https://twitter.com/intent/follow?screen_name=localheinz) and [@ergebnis](https://twitter.com/intent/follow?screen_name=ergebnis) on Twitter.
