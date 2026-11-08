# `ergebnis/.github/actions/github/release/publish`

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
        uses: "ergebnis/.github/actions/github/release/publish@1.16.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
          release-id: "9001"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `github-token`, required: The GitHub token of a user with permission to create a release.
- `release-id`, required: The release identifier.

## Outputs

none

## Side Effects

- The release identified by the release identifier is published by the user who owns the GitHub token specified with the `github-token` input.
- The `RELEASE_HTML_URL` environment variable contains the HTML URL to the published release.
