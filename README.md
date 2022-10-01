# .github

[![Integrate](https://github.com/ergebnis/.github/workflows/Integrate/badge.svg?branch=main)](https://github.com/ergebnis/.github/actions)
[![Merge](https://github.com/ergebnis/.github/workflows/Merge/badge.svg?branch=main)](https://github.com/ergebnis/.github/actions)
[![Release](https://github.com/ergebnis/.github/workflows/Release/badge.svg?branch=main)](https://github.com/ergebnis/.github/actions)
[![Triage](https://github.com/ergebnis/.github/workflows/Triage/badge.svg?branch=main)](https://github.com/ergebnis/.github/actions)

Provides community health files for the [@ergebnis](https://github.com/ergebnis) organization.

:bulb: Also see [GitHub Docs: Creating a default community health file](https://docs.github.com/en/github/building-a-strong-community/creating-a-default-community-health-file).

## Composite Actions

This repository provides the following composite actions:

- [`ergebnis/.github/actions/composer/determine-cache-directory`](#composer-determine-cache-directory)
- [`ergebnis/.github/actions/composer/determine-root-version`](#composer-determine-root-version)
- [`ergebnis/.github/actions/composer/install`](#composer-install)
- [`ergebnis/.github/actions/github/pull-request/add-assignee`](#github-pull-request-add-assignee)
- [`ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`](#github-pull-request-add-label-based-on-branch-name)
- [`ergebnis/.github/actions/github/pull-request/approve`](#github-pull-request-approve)
- [`ergebnis/.github/actions/github/pull-request/merge`](#github-pull-request-merge)
- [`ergebnis/.github/actions/github/pull-request/request-review`](#github-pull-request-review)
- [`ergebnis/.github/actions/github/release/create`](#github-release-create)

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
        uses: "ergebnis/.github/actions/composer/determine-cache-directory@1.5.1"

      - name: "Cache dependencies installed with composer"
        uses: "actions/cache@v3.0.8"
        with:
          path: "${{ env.COMPOSER_CACHE_DIR }}"
          key: "composer-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-"
```

For details, see [`actions/composer/determine-cache-directory/action.yaml`](actions/composer/determine-cache-directory/action.yaml).

#### Inputs

- `working-directory`, optional: The working directory to use. Defaults to `"'"."`.

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
        uses: "ergebnis/.github/actions/composer/determine-root-version@1.5.1"
```

For details, see [`actions/composer/determine-root-version/action.yaml`](actions/composer/determine-root-version/action.yaml).

#### Inputs

- `branch`, optional: The name of the branch, defaults to `"main"`.
- `working-directory`, optional: The working directory to use, defaults to `"."`.

#### Outputs

none

#### Side Effects

The `COMPOSER_ROOT_VERSION` environment variable contains the root version if it has been defined as `branch-alias` in `composer.json`.

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
        uses: "ergebnis/.github/actions/composer/determine-cache-directory@1.5.1"

      - name: "Cache dependencies installed with composer"
        uses: "actions/cache@v3.0.8"
        with:
          path: "${{ env.COMPOSER_CACHE_DIR }}"
          key: "composer-${{ matrix.dependencies }}-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-${{ matrix.dependencies }}-"

      - name: "Install ${{ matrix.dependencies }} dependencies with composer"
        uses: "ergebnis/.github/actions/composer/install@1.5.1"
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

When `dependencies` is set to `"lowest"`, dependencies are installed in the directory specified by `working-directory` with

```shell
composer update --ansi --no-interaction --no-progress --prefer-lowest
````
When `dependencies` is set to `"locked"`, dependencies are installed in the directory specified by `working-directory` with

```shell
composer install --ansi --no-interaction --no-progress
```

When `dependencies` is set to `"highest"`, dependencies are installed in the directory specified by `working-directory` with

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
        uses: "ergebnis/.github/actions/github/pull-request/add-assignee@1.5.1"
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

The GitHub user with the username specified in the `assignee` input is assigned to the pull request.

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
        uses: "ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name@1.5.1"
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
        uses: "ergebnis/.github/actions/github/pull-request/approve@1.5.1"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/pull-request/merge/action.yaml`](actions/github/pull-request/merge/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to approve a pull request

#### Outputs

none

#### Side Effects

The pull request is approved by the user who owns the GitHub token specified with the `github-token` input.

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
        uses: "ergebnis/.github/actions/github/pull-request/merge@1.5.1"
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

The pull request is merged by the user who owns the GitHub token specified with the `github-token` input.

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
        uses: "ergebnis/.github/actions/github/pull-request/request-review@1.5.1"
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

A pull request review is requested for the user identified by the value of the `reviewer` input by the user who owns the GitHub token specified with the `github-token` input.

### <a name="github-release-create"> `ergebnis/.github/actions/github/release/create`

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
        uses: "ergebnis/.github/actions/github/release/create@1.5.1"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`actions/github/release/create/action.yaml`](actions/github/release/create/action.yaml).

#### Inputs

- `github-token`, required: The GitHub token of a user with permission to create a release.

#### Outputs

none

#### Side Effects

A release is created by the user who owns the GitHub token specified with the `github-token` input.

## Changelog

Please have a look at [`CHANGELOG.md`](CHANGELOG.md).

## Contributing

Please have a look at [`CONTRIBUTING.md`](.github/CONTRIBUTING.md).

## Code of Conduct

Please have a look at [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## Curious what I am building?

:mailbox_with_mail: [Subscribe to my list](https://localheinz.com/projects/), and I will occasionally send you an email to let you know what I am working on.
