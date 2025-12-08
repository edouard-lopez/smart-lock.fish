#!/usr/bin/make -sf

# force use of Bash
SHELL := /usr/bin/env bash
INTERACTIVE=true


.PHONY: default
default: usage
usage:
	@printf "usage:"
	@printf "\tmake build-smart-lock-on FISH_VERSION=3.3.1\t# build container\n"
	@printf "\tmake test-smart-lock-on  FISH_VERSION=3.3.1\t# run tests\n"
	@printf "\tmake dev-smart-lock-on   FISH_VERSION=3.3.1\t# dev in container\n"

.PHONY: build-smart-lock-on
build-smart-lock-on: STAGE?=with-smart-lock-installed
build-smart-lock-on:
	docker build \
		--file ./docker/Dockerfile \
		--target ${STAGE} \
		--build-arg FISH_VERSION=${FISH_VERSION} \
		--tag=smart-lock-${STAGE}-${FISH_VERSION} \
		--load \
		./

.PHONY: dev-smart-lock-on
dev-smart-lock-on: CMD?=fish
dev-smart-lock-on: STAGE?=with-smart-lock-installed
dev-smart-lock-on: TTY_FLAG?=$(shell [ -z "$$CI" ] && echo "--tty" || echo "")
dev-smart-lock-on: USER_FLAG?=$(shell [ -z "$$CI" ] && echo "--user $$(id -u):$$(id -g)" || echo "")
dev-smart-lock-on: build-with-smart-lock-installed
	docker run \
		--name dev-smart-lock-on-${FISH_VERSION} \
		--rm \
		--interactive \
		$(TTY_FLAG) \
        $(USER_FLAG) \
        --env HOME=/home/nemo \
        --env XDG_CONFIG_HOME=/home/nemo/.config \
        --env XDG_DATA_HOME=/home/nemo/.local/share \
		--volume=$$(pwd):/home/nemo/.config/fish/smart-lock/ \
		--workdir /home/nemo/.config/fish/smart-lock/ \
		smart-lock-${STAGE}-${FISH_VERSION} "fish --version && ${CMD}"

.PHONY: test-smart-lock-on
test-smart-lock-on: CMD?=fishtape tests/*.test.fish
test-smart-lock-on: STAGE?=with-smart-lock-installed
test-smart-lock-on: build-with-smart-lock-installed
	docker run \
		--name test-smart-lock-on-${FISH_VERSION} \
		--rm \
		--tty \
		smart-lock-${STAGE}-${FISH_VERSION} "fish --version && ${CMD}"

.PHONY: build-with-smart-lock-installed
build-with-smart-lock-installed:
	$(MAKE) build-smart-lock-on FISH_VERSION=${FISH_VERSION} STAGE=with-smart-lock-installed

.PHONY: dev-with-smart-lock-installed
dev-with-smart-lock-installed:
	$(MAKE) build-smart-lock-on FISH_VERSION=${FISH_VERSION} STAGE=with-smart-lock-installed
	$(MAKE) dev-smart-lock-on FISH_VERSION=${FISH_VERSION} STAGE=with-smart-lock-installed
