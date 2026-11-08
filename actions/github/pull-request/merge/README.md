# `ergebnis/.github/actions/github/pull-request/merge`

This action merges a pull request.

This is useful when you want to automatically merge a pull request, for example, opened by [`dependabot`](https://github.com/dependabot).

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
      - name: "Merge pull request"
        uses: "ergebnis/.github/actions/github/pull-request/merge@1.16.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `github-token`, required: The GitHub token of a user with permission to merge a pull request
- `merge-method`, optional: The merge method to use, one of `"merge"`, `"rebase"`, `"squash"`, defaults to `"merge"`

## Outputs

none

## Side Effects

- The pull request is merged by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.
