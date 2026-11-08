# `ergebnis/.github/actions/oh-dear/maintenance-period/start`

This action starts a [maintenance period](https://ohdear.app/docs/general/maintenance-windows) on [Oh Dear!](https://ohdear.app).

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

      - name: "Start maintenance period on ohdear.app"
        uses: "ergebnis/.github/actions/oh-dear/maintenance-period/start@1.17.0"
        with:
          oh-dear-api-token: "${{ secrets.OH_DEAR_API_TOKEN }}"
          oh-dear-site-id: "${{ secrets.OH_DEAR_SITE_ID }}"
          oh-dear-stop-maintenance-after-seconds: "7200"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `oh-dear-api-token`, required: The Oh Dear API token of a user with permission to start a maintenance period
- `oh-dear-site-id`, required: Site identifier of an Oh Dear site for which to start a maintenance period
- `oh-dear-stop-maintenance-after-seconds`, optional: The number of seconds after which Oh Dear stops the maintenance period, from `5` to `999999999`. When empty, Oh Dear stops the maintenance period after `3600` seconds. Defaults to `""`.

## Outputs

none

## Side Effects

- A maintenance period is started by the user who owns the Oh Dear API token specified with the `oh-dear-api-token` input for the site identified by the `oh-dear-site-id` input.
- When Oh Dear does not respond with a `2xx` status, the step fails, including when it rate-limits the request, since a maintenance period that has not started does not suppress notifications. The status, the `Retry-After` header, and the response body are reported.
