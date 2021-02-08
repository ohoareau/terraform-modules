layers ?= $(shell cd layers && ls -d */ 2>/dev/null | sed s,/,,)
makeable_layers ?= $(shell cd layers && ls -d */Makefile 2>/dev/null | sed s,/Makefile,,)
modules ?= $(shell cd modules && ls -d */ 2>/dev/null | sed s,/,,)
makeable_modules ?= $(shell cd modules && ls -d */Makefile 2>/dev/null | sed s,/Makefile,,)

all: install

build-layers: install-root
	@$(foreach l,$(makeable_layers),make -C layers/$(l)/ build;)
build-modules: install-root
	@$(foreach m,$(makeable_modules),make -C modules/$(m)/ build;)

generate:
	@yarn --silent genjs
generate-docs: generate-docs-layers generate-docs-modules
generate-docs-layers: install-root
	@$(foreach l,$(layers),cd layers/$(l) && terraform-docs markdown . > README.md && cd ../..;)
generate-docs-modules: install-root
	@$(foreach m,$(modules),cd modules/$(m) && terraform-docs markdown . > README.md && cd ../..;)

install: install-root install-layers install-modules
install-layers: install-root
	@$(foreach l,$(makeable_layers),make -C layers/$(l)/ install;)
install-modules: install-root
	@$(foreach m,$(makeable_modules),make -C modules/$(m)/ install;)
install-root:
	@yarn --silent install

layer-build:
	@make -C layers/$(l)/ build
layer-generate-docs: install-root
	@cd layers/$(l) && terraform-docs markdown . > README.md && cd ../..
layer-install:
	@make -C layers/$(l)/ install
layer-test:
	@make -C layers/$(l)/ test

module-build:
	@make -C modules/$(m)/ build
module-generate-docs: install-root
	@cd modules/$(m) && terraform-docs markdown . > README.md && cd ../..
module-install:
	@make -C modules/$(m)/ install
module-test:
	@make -C modules/$(m)/ test

pr:
	@hub pull-request -b $(b)

test-layers: install-root
	@$(foreach l,$(makeable_layers),make -C layers/$(l)/ test;)
test-modules: install-root
	@$(foreach m,$(makeable_modules),make -C modules/$(m)/ test;)

.PHONY: all \
		build-layers build-modules \
		generate generate-docs generate-docs-layers generate-docs-modules \
		install install-layers install-modules install-root \
		layer-build layer-generate-docs layer-install layer-test \
		module-build module-generate-docs module-install module-test \
		pr \
		test-layers test-modules