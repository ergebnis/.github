# `ergebnis/.github/actions/sentry/release/create`

This action creates a [release](https://docs.sentry.io/product/releases/) on [Sentry](https://sentry.io) with [`sentry-cli`](https://github.com/getsentry/sentry-cli), associates commits with it, finalizes it, and records a deploy.

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
        uses: "actions/checkout@v7.0.1"
        with:
          fetch-depth: 0

      - name: "Create release on Sentry"
        uses: "ergebnis/.github/actions/sentry/release/create@1.16.0"
        with:
          sentry-auth-token: "${{ secrets.SENTRY_AUTH_TOKEN }}"
          sentry-environment: "production"
          sentry-organization: "example"
          sentry-project: "example"
          sentry-release: "${{ github.sha }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `sentry-auth-token`, required: Sentry auth token with permission to create releases and deploys
- `sentry-environment`, required: Name of the environment to which the release has been deployed
- `sentry-organization`, required: Slug of the Sentry organization
- `sentry-project`, required: Slug of the Sentry project
- `sentry-release`, required: Version of the release

## Outputs

none

## Side Effects

- `sentry-cli` is installed in the same way as with [`ergebnis/.github/actions/sentry/cli/install`](../../cli/install/README.md), so later steps of the job can run `sentry-cli` as well.
- The release identified by the `sentry-release` input is created in the project identified by the `sentry-organization` and `sentry-project` inputs, by the user or organization that owns the auth token specified with the `sentry-auth-token` input.
- Commits are associated with the release with `sentry-cli releases set-commits --auto --ignore-missing`, which reads the repository in the working directory. The job needs a checkout with enough history to contain the commit of the previous release, for example with `fetch-depth: 0`, and the Sentry organization needs the repository integration.
- The release is finalized, and a deploy to the environment specified with the `sentry-environment` input is recorded.
