# `ergebnis/.github/actions/composer/determine-root-version`

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
        uses: "actions/checkout@v7.0.1"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.40.0"
        with:
          coverage: "none"
          php-version: "8.1"

      - name: "Determine composer root version"
        uses: "ergebnis/.github/actions/composer/determine-root-version@1.17.0"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `branch`, optional: The name of the branch, defaults to `"main"`.
- `working-directory`, optional: The working directory to use, defaults to `"."`.

## Outputs

none

## Side Effects

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
