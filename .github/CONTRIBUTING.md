# CONTRIBUTING

We use [GitHub Actions](https://github.com/features/actions) as a continuous integration system.

For details, take a look at the following workflow configuration files:

- [`workflows/integrate.yaml`](workflows/integrate.yaml)
- [`workflows/merge.yaml`](workflows/merge.yaml)
- [`workflows/triage.yaml`](workflows/triage.yaml)

## Coding Standards

We use [`yamllint`](https://github.com/adrienverge/yamllint) to enforce coding standards in YAML files.

If you do not have `yamllint` installed yet, run

```sh
brew install yamllint
```

to install `yamllint`.

Run

```sh
make coding-standards
```

to detect coding standard violations.

## Documentation

The `README.md` of each composite action documents it. The list and the sections of composite actions in [`README.md`](../README.md) are generated from them.

After changing the `README.md` of a composite action, run

```sh
make documentation
```

to update [`README.md`](../README.md).

## Extra lazy?

Run

```sh
make
```

to detect coding standard violations and update the documentation!

## Help

:bulb: Run

```sh
make help
```

to display a list of available targets with corresponding descriptions.
