# `ergebnis/.github/actions/github/pull-request/approve`

This action approves a pull request.

This is useful when you want to automatically merge a pull request, but prefer to let a bot user approve the pull request beforehand.

```yaml
name: "Merge"

on:
  workflow_run:
    types:
      - "completed"
    workflows:
      - "Integrate"

jobs:
  merge:
    name: "Merge"

    runs-on: "ubuntu-latest"

    if: >
      github.event.workflow_run.event == 'pull_request' &&
      github.event.workflow_run.conclusion == 'success' &&
      github.event.workflow_run.actor.login == 'dependabot[bot]' &&
      github.event.workflow_run.head_repository.full_name == github.repository && (
        startsWith(github.event.workflow_run.head_commit.message, 'composer(deps-dev)') ||
        startsWith(github.event.workflow_run.head_commit.message, 'github-actions(deps)')
      )

    steps:
      - name: "Approve pull request"
        uses: "ergebnis/.github/actions/github/pull-request/approve@1.16.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `github-token`, required: The GitHub token of a user with permission to approve a pull request

## Outputs

none

## Side Effects

- The pull request is approved by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.
