# `ergebnis/.github/actions/composer/determine-cache-directory`

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
          key: "composer-${{ hashFiles('composer.lock') }}"
          restore-keys: "composer-"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `working-directory`, optional: The working directory to use. Defaults to `"."`.

## Outputs

none

## Side Effects

- The `COMPOSER_CACHE_DIR` environment variable contains the path to the composer cache directory.
