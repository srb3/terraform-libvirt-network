.PHONY: all build test out clean

SHELL = /bin/bash

all: build test

build: build_prep_default build_default

clean: clean_default

build_prep_default:
	@pushd examples/default; \
	terraform init; \
	popd

build_default:
	@pushd examples/default; \
	terraform apply -auto-approve; \
	popd

test: test_default

test_default:
	cinc-auditor exec test/integration/default/ \
		--input-file test/integration/attributes/default/attrs.yml \
		--reporter=cli json:test-result-default-$$(date "+%Y.%m.%d-%H.%M.%S").json

out_default:
	@pushd examples/default; \
	terraform output; \
	popd

clean_default:
	@pushd examples/default; \
	terraform destroy -auto-approve; \
	popd
