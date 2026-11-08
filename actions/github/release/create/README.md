# `ergebnis/.github/actions/github/release/create`

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
        uses: "ergebnis/.github/actions/github/release/create@1.17.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `draft`, optional: Whether to create a draft or a published release.
- `github-token`, required: The GitHub token of a user with permission to create a release.
- `prerelease`, optional: Whether to identify the release as a prerelease or a full release.

## Outputs

none

## Side Effects

- A release is created by the user who owns the GitHub token specified with the `github-token` input.
- The `RELEASE_HTML_URL` environment variable contains the HTML URL to the release.
- The `RELEASE_ID` environment variable contains the release identifier.
- The `RELEASE_TAG` environment variable contains the release tag.
- The `RELEASE_UPLOAD_URL` environment variable contains the URL for uploading release assets.
