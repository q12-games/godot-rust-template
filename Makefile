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

check: verify-params
	$(CARGO) clippy --target $(CARGO_TARGET)
	@touch ./target/.gdignore ./godot/libs/.empty

test: build
	sh ./test/run-tests.sh

clean:
	@rm -rf target
	@rm -rf ./godot/libs/*
	@mkdir ./target
	@rm -rf **/*.import
	@echo "Done"

export: build
	@echo "Exporting $(TARGET) build"
	@echo "$(GODOT_PLATFORM) $(CARGO_TARGET)"
	mkdir -p ./target/godot-$(TARGET);
	$(GODOT_TEST_BIN) --export $(GODOT_PLATFORM) ./target/godot-$(TARGET)/game$(BIN_SUFFIX)

nix-export:
	nix-shell ./nix-envs/build-$(TARGET).nix --run 'make export TARGET=$(TARGET)'

.PHONY: build

