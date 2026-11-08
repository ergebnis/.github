# `ergebnis/.github/actions/composer/install`

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
        uses: "actions/checkout@v7.0.1"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.40.0"
        with:
          coverage: "none"
          php-version: "8.1"

      - name: "Determine composer cache directory"
        uses: "ergebnis/.github/actions/composer/determine-cache-directory@1.17.0"

      - name: "Cache dependencies installed with composer"
        uses: "actions/cache@v6.1.0"
        with:
          path: "${{ env.COMPOSER_CACHE_DIR }}"
          key: "composer-${{ matrix.dependencies }}-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-${{ matrix.dependencies }}-"

      - name: "Install ${{ matrix.dependencies }} dependencies with composer"
        uses: "ergebnis/.github/actions/composer/install@1.17.0"
        with:
          dependencies: "${{ matrix.dependencies }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `dependencies`, optional: Which dependencies to install, one of `"lowest"`, `"locked"`, `"highest"`
- `working-directory`, optional: The working directory to use, defaults to `"."`.

## Outputs

none

## Side Effects

- Before installing dependencies, the version of `composer` is shown with `composer --version`. When `composer` cannot be run, for example because `shivammathur/setup-php` could not download it, the step fails with an error message.

- When `dependencies` is set to `"lowest"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer update --ansi --no-interaction --no-progress --prefer-lowest
  ```

- When `dependencies` is set to `"locked"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer install --ansi --no-interaction --no-progress
  ```

- When `dependencies` is set to `"highest"`, dependencies are installed in the directory specified by `working-directory` with

  ```shell
  composer update --ansi --no-interaction --no-progress
  ```
