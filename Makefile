.PHONY: it
it: coding-standards ## Runs the coding-standards target

.PHONY: coding-standards
coding-standards: ## Lints YAML files with yamllint
	yamllint -c .yamllint.yaml --strict .

.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'
