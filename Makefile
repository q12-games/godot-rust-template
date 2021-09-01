# Config
CARGO = cargo
TARGET = linux
GODOT_TEST_BIN = godot-headless
GODOT_PLATFORM = ${_GODOT_${TARGET}}
CARGO_TARGET = ${_CARGO_TARGET_${TARGET}}
BIN_SUFFIX = ${_SUFFIX_${TARGET}}


# Cases
_GODOT_linux = Linux
_GODOT_windows = Windows

_CARGO_TARGET_linux = x86_64-unknown-linux-gnu
_CARGO_TARGET_windows = x86_64-pc-windows-gnu
# _CARGO_TARGET_android = 
#  x86_64-linux-android
# aarch64-linux-android
# i686-linux-android
# x86_64-linux-android

_SUFFIX_linux = ""
_SUFFIX_windows = ".exe"

verify-params:
ifeq ($(CARGO_TARGET), )
	@echo "Invalid target used: $(TARGET)"
	exit 1
endif

build: verify-params
	$(CARGO) build --target $(CARGO_TARGET)
	@touch ./target/.gdignore ./godot/libs/.empty

check:
	$(CARGO) clippy

run-test:
	sh ./test/run-tests.sh

test: build run-test

clean:
	@rm -rf target
	@rm -rf ./godot/libs/*
	@mkdir ./target
	@touch ./target/.gdignore ./godot/libs/.empty
	@rm -rf **/*.import
	@echo "Done"

export: build run-test
	@echo "Exporting $(TARGET) build"
	@echo "$(GODOT_PLATFORM) $(CARGO_TARGET)"
	mkdir -p ./target/godot-linux;
	$(GODOT_TEST_BIN) --export $(GODOT_PLATFORM) ./target/godot-$(TARGET)/game$(BIN_SUFFIX)

.PHONY: build

