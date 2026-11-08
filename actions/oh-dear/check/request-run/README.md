# `ergebnis/.github/actions/oh-dear/check/request-run`

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
        uses: "actions/checkout@v7.0.1"
        with:
          fetch-depth: 50

      - name: "Request broken links check on ohdear.app"
        uses: "ergebnis/.github/actions/oh-dear/check/request-run@1.17.0"
        with:
          oh-dear-api-token: "${{ secrets.OH_DEAR_API_TOKEN }}"
          oh-dear-check-id: "${{ secrets.OH_DEAR_BROKEN_LINKS_CHECK_ID }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `oh-dear-api-token`, required: The Oh Dear API token of a user with permission to request a check run
- `oh-dear-check-id`, required: Check identifier of an Oh Dear check for which to request a run

## Outputs

none

## Side Effects

- A check run is requested by the user who owns the Oh Dear API token specified with the `oh-dear-api-token` input for the check identified by the `oh-dear-check-id` input.
- When Oh Dear rate-limits the request, responding with `429 Too Many Requests`, a warning is emitted and the step succeeds. Oh Dear accepts a run request for a check every 60 minutes, so a deployment that follows another one closely is declined, and the run that has been accepted covers it as well.
- When Oh Dear responds with any other status than `2xx`, the step fails. The status, the `Retry-After` header, and the response body are reported in either case.
