# `ergebnis/.github/actions/sentry/cli/install`

This action installs [`sentry-cli`](https://github.com/getsentry/sentry-cli).

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
      - name: "Install sentry-cli"
        uses: "ergebnis/.github/actions/sentry/cli/install@1.17.0"

      - name: "Show information about the Sentry auth token"
        env:
          SENTRY_AUTH_TOKEN: "${{ secrets.SENTRY_AUTH_TOKEN }}"
        run: "sentry-cli info"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

none

## Outputs

- `path`: Path to the `sentry-cli` binary

## Side Effects

- `sentry-cli` is downloaded from [`getsentry/sentry-cli`](https://github.com/getsentry/sentry-cli/releases) into a directory in `RUNNER_TEMP` and verified against a SHA-256 checksum pinned in [`install.sh`](install.sh). The step fails on a runner other than Linux on `X64` or `ARM64`, and when the checksum does not match.
- The directory containing `sentry-cli` is added to `GITHUB_PATH`, so later steps of the job can run `sentry-cli`.
- When the directory already contains `sentry-cli` with the pinned checksum, for example because an earlier step of the job installed it, the download is skipped.
