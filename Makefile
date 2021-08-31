CARGO = cargo

build:
	$(CARGO) build

check:
	$(CARGO) clippy

run-test:
	sh ./test/run-tests.sh

test: build run-test

.PHONY: build

