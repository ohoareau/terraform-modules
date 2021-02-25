all: install

install:
	@cd code && npm_config_arch=x64 npm_config_platform=linux yarn --silent install --prod

build:
	@cd code && yarn --silent build

test:
	@cd  code && yarn --silent test


.PHONY: all build install test