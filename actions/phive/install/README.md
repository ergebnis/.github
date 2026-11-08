# `ergebnis/.github/actions/phive/install`

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
        uses: "actions/checkout@v7.0.1"

      - name: "Set up PHP"
        uses: "shivammathur/setup-php@2.40.0"
        with:
          coverage: "none"
          php-version: "8.1"
          tools: "phive"

      - name: "Install dependencies with phive"
        uses: "ergebnis/.github/actions/phive/install@1.17.0"
        with:
          trust-gpg-keys: "0x033E5F8D801A2F8D,0x2A8299CE842DD38C"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `phive-home`, optional: Which directory to use as `PHIVE_HOME` directory, defaults to `".build/phive"`.
- `trust-gpg-keys`, required: Which GPG keys to trust, a comma-separated list of trusted GPG keys

## Outputs

none

## Side Effects

- Given that `phive` is available, `phive` could find a `phars.xml`, and keys presented by packages are listed using the `trust-gpg-keys` option, dependencies are installed with `phive`.
- Before installing dependencies, the version of `phive` is shown with `phive --version`. When `phive` cannot be run, for example because `shivammathur/setup-php` could not download it, the step fails with an error message.

The directory configured by the `phive-home` directory is cached using [`actions/cache`](https://github.com/actions/cache).
