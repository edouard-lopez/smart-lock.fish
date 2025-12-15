#!/usr/bin/make -sf

# force use of Bash
SHELL := /usr/bin/env bash
INTERACTIVE=true


.PHONY: default
default: usage
usage:
	@printf "usage:"
	@printf "\tmake build-project-on FISH_VERSION=3.3.1\t# build container\n"
	@printf "\tmake test-project-on  FISH_VERSION=3.3.1\t# run tests\n"
	@printf "\tmake dev-project-on   FISH_VERSION=3.3.1\t# dev in container\n"

.PHONY: build-project-on
build-project-on: STAGE?=with-project-installed
build-project-on:
	docker build \
		--file ./docker/Dockerfile \
		--target ${STAGE} \
		--build-arg FISH_VERSION=${FISH_VERSION} \
		--tag=project-${STAGE}-${FISH_VERSION} \
		--load \
		./

.PHONY: dev-project-on
dev-project-on: CMD?=fish
dev-project-on: STAGE?=with-project-installed
dev-project-on: TTY_FLAG?=$(shell [ -z "$$CI" ] && echo "--tty" || echo "")
dev-project-on: USER_FLAG?=$(shell [ -z "$$CI" ] && echo "--user $$(id -u):$$(id -g)" || echo "")
dev-project-on: build-with-project-installed
	docker run \
		--name dev-project-on-${FISH_VERSION} \
		--rm \
		--interactive \
		$(TTY_FLAG) \
        $(USER_FLAG) \
        --env HOME=/home/nemo \
        --env XDG_CONFIG_HOME=/home/nemo/.config \
        --env XDG_DATA_HOME=/home/nemo/.local/share \
		--volume=$$(pwd):/home/nemo/.config/fish/project/ \
		--workdir /home/nemo/.config/fish/project/ \
		project-${STAGE}-${FISH_VERSION} "fish --version && ${CMD}"

.PHONY: test-project-on
test-project-on: CMD?=fishtape tests/*.test.fish
test-project-on: STAGE?=with-project-installed
test-project-on: build-with-project-installed
	docker run \
		--name test-project-on-${FISH_VERSION} \
		--rm \
		--tty \
		project-${STAGE}-${FISH_VERSION} "fish --version && ${CMD}"

.PHONY: build-with-project-installed
build-with-project-installed:
	$(MAKE) build-project-on FISH_VERSION=${FISH_VERSION} STAGE=with-project-installed

.PHONY: dev-with-project-installed
dev-with-project-installed:
	$(MAKE) build-project-on FISH_VERSION=${FISH_VERSION} STAGE=with-project-installed
	$(MAKE) dev-project-on FISH_VERSION=${FISH_VERSION} STAGE=with-project-installed
