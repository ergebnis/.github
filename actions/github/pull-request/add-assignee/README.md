# `ergebnis/.github/actions/github/pull-request/add-assignee`

This action adds an assignee to a pull request.

This is useful when you want to automatically merge a pull request, but prefer to assign a bot user beforehand.

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
      - name: "Assign @ergebnis-bot"
        uses: "ergebnis/.github/actions/github/pull-request/add-assignee@1.17.0"
        with:
          assignee: "ergebnis-bot"
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `assignee`, required: The username of a user to add as an assignee to a pull request.
- `github-token`, required: The GitHub token of a user with permission to add assignees to a pull request

## Outputs

none

## Side Effects

- The GitHub user with the username specified in the `assignee` input is assigned to the pull request.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.
