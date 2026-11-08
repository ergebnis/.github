# `ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name`

This action adds a label to a pull request based on the name of the branch.

```yaml
# https://docs.github.com/en/actions

name: "Triage"

on: # yamllint disable-line rule:truthy
  pull_request_target:
    types:
      - "opened"

jobs:
  label:
    name: "Label"

    runs-on: "ubuntu-latest"

    steps:
      - name: "Add labels based on branch name"
        uses: "ergebnis/.github/actions/github/pull-request/add-label-based-on-branch-name@1.16.0"
        with:
          github-token: "${{ secrets.ERGEBNIS_BOT_TOKEN }}"
```

For details, see [`action.yaml`](action.yaml).

## Inputs

- `github-token`, required: The GitHub token of a user with permission to add labels to to a pull request.

## Outputs

none

## Side Effects

- When the branch name starts with `fix/` (or `bug/`), the label `bug` is added to the pull request by the user who owns the GitHub token specified with the `github-token` input.
- When the branch name starts with `enhancement/` (or `feature/`), the label `enhancement` is added to the pull request by the user who owns the GitHub token specified with the `github-token` input.
- The `PULL_REQUEST_BRANCH_NAME` environment variable contains the name of the head branch of the pull request.
- The `PULL_REQUEST_NUMBER` environment variable contains the number of the pull request.
