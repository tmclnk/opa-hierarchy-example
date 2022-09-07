include .env
.PHONY: help
OPA_HOST = localhost:8181

# We need these
ifndef STYRA_SYSTEM_URL
$(warning STYRA_SYSTEM_URL is unset)
endif
ifndef STYRA_SYSTEM_URL
$(warning STYRA_SYSTEM_URL is unset)
endif

help: ## Print Help
	@grep -Eh '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

fmt: ## opa format
	@opa fmt -w *.rego

test: ## opa test
	opa test . -v

################################################################################
# local server agent
################################################################################
server-styra: ## start opa server (requires styra opa-conf.yaml)
	opa run --server --config-file=opa-conf.yaml

get-policies: ## get policies from local server
	@curl ${OPA_HOST}/v1/policies

################################################################################
# Command-line evals
################################################################################
data: ## show all base and virtual data
	@opa eval --bundle . --input input.json --data data.json --format pretty 'data'

effective_security_level: ## print effective security level based on input.json and data.json
	@opa eval --bundle . --input input.json --data data.json --format pretty 'data.rules.effective_security_level'

org_chart_data: ## dump the org chart
	@opa eval --bundle . --data data.json --format pretty 'data.org_chart_data'

role_data: ## dump the role tree
	@opa eval --bundle . --data data.json --format pretty 'data.role_data'

repl: ## start a repl using data.json and input.json
	@opa run . repl.input:input.json
