# CONFIG: Name of your game (will be used to create the exported binary)
GAME_NAME = my-game
# CONFIG: Cargo binary name
CARGO = cargo
# CONFIG: Default target (Supports: linux | windows)
TARGET = linux
# CONFIG: Godot binary used for exporting
GODOT_TEST_BIN = godot-headless


# Cases
_GODOT_linux = Linux
_GODOT_windows = Windows

_CARGO_TARGET_linux = x86_64-unknown-linux-gnu
_CARGO_TARGET_windows = x86_64-pc-windows-gnu

_SUFFIX_linux = ""
_SUFFIX_windows = ".exe"

# Derived
GODOT_PLATFORM = ${_GODOT_${TARGET}}
CARGO_TARGET = ${_CARGO_TARGET_${TARGET}}
BIN_SUFFIX = ${_SUFFIX_${TARGET}}

verify-params:
ifeq ($(CARGO_TARGET), )
	@echo "Invalid target used: $(TARGET)"
	exit 1
endif

# Build rust library: `make build TARGET=linux`
build: verify-params
	$(CARGO) build --target $(CARGO_TARGET)
	touch ./target/.gdignore ./godot/libs/.empty

# Run clippy and rustfmt
check: verify-params
	$(CARGO) clippy --target $(CARGO_TARGET)
	rustfmt --check ./{core,test,lib}/src/*.rs
	touch ./target/.gdignore ./godot/libs/.empty

# Run all tests: `make test`
# Run specific test (with regex): `make test TEST="player.*jump"`
TEST = ""
test: build
	sh ./test/run-tests.sh $(TEST)

# Run tests and watch rust files for changes
test-watch: build
	cargo watch -s 'clear && make test TEST=$(TEST)' -i godot

# Cleanup build artifacts
clean:
	cargo clean
	@rm -rf ./godot/libs/*
	@rm -rf **/*.import
	@echo "Cleanup done"

# Export godot game: `make export TARGET=windows`
export: build
	@echo "Exporting $(TARGET) build"
	@echo "$(GODOT_PLATFORM) $(CARGO_TARGET)"
	mkdir -p ./target/godot-$(TARGET);
	$(GODOT_TEST_BIN) --export $(GODOT_PLATFORM) ./target/godot-$(TARGET)/$(GAME_NAME)$(BIN_SUFFIX)

# Nix alias for export
nix-export:
	nix-shell ./nix-envs/build-$(TARGET).nix --run 'make export TARGET=$(TARGET)'

