.PHONY: all build test clean

SHELL = /bin/bash

all: all_default all_override
all_default: build_default test_default clean_default
build_default: build_deployment_default
test_default: test_deployment_default
clean_default: clean_deployment_default

build_deployment_default:
	@pushd examples/default; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_default:
	cinc-auditor exec test/integration/default/ \
		--input-file test/integration/default/attrs.yml

clean_deployment_default:
	@pushd examples/default; \
	terraform destroy -auto-approve; \
	popd

all_override: build_override test_override clean_override
build_override: build_deployment_override
test_override: test_deployment_override
clean_override: clean_deployment_override

build_deployment_override:
	@pushd examples/override; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_override:
	cinc-auditor exec test/integration/override/ \
		--input-file test/integration/override/attrs.yml

clean_deployment_override:
	@pushd examples/override; \
	terraform destroy -auto-approve; \
	popd
