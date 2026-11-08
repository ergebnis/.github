# `ergebnis/.github/actions/github/pull-request/enable-auto-merge`

This action enables auto-merge for a pull request.

This is useful when you want to automatically merge pull requests, for example, opened by [`dependabot`](https://github.com/dependabot), and let GitHub merge them one after another. When several pull requests are merged directly at the same time, GitHub rejects all but the first with `Base branch was modified`.

Enable auto-merge before approving the pull request: GitHub refuses to enable auto-merge for a pull request that can already be merged.

This action requires the repository to [allow auto-merge](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-auto-merge-for-pull-requests-in-your-repository), otherwise GitHub refuses to enable auto-merge and the step fails.

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
      - name: "Enable auto-merge for pull request"
        uses: "ergebnis/.github/actions/github/pull-request/enable-auto-merge@1.17.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"

      - name: "Approve pull request"
        uses: "ergebnis/.github/actions/github/pull-request/approve@1.17.0"
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

- Auto-merge is enabled for the pull request by the user who owns the GitHub token specified with the `github-token` input, and GitHub merges the pull request once it satisfies the branch protection rules.
- When the pull request can already be merged, GitHub refuses to enable auto-merge, and the pull request is merged right away instead. When GitHub rejects that merge because the base branch was modified, for example, by a pull request merged at the same time, the merge is retried up to five times.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.
