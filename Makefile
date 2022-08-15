.PHONY: help

help: ## Print Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

fmt: ## opa format
	opa fmt -w *.rego

test: ## opa test
	opa test . -v

eval: ## print effective security level based on input.json and data.json
	opa eval --bundle . --input input.json --data data.json --format pretty 'data.branch_hierarchy.effective_security_level'
