# godot-rust template
Project template for godot-rust project with unit tests and some utility helpers


## Features
* Unit testing within the godot engine (headless by default)
* Automatically generates `.gdnlib` and `.gdns` files for your scenes
* Write less boilerplate code with class extension macros
* Build configured for `windows` and `linux` platforms (create an issue to request additional platforms)


## Getting started

#### Setup
* Fork this project
* Change the package name inside `lib/Cargo.toml`, to the name of your game
* Set `GAME_NAME` in `Makefile` to the name of your game
* Add `x86_64-unknown-linux-gnu` and `x86_64-pc-windows-gnu` targets using rustup

#### Build
* Run `make build` to build for linux (default configured in Makefile)
* Run `make build TARGET=windows` to build for windows
* Run `make clean` to clean artifacts and `make clean build` to clean and then build

#### Run tests
* Run `make test` to run all tests for the default platform
* Run `make test TEST="player.*walk"` to only run tests that match given regex
* Run `make test-watch` to run all tests and watch source files for changes

#### Exporting
* Run `make export` to export a build inside `target/godot-linux` (defaults to linux in Makefile)
* Run `make export TARGET=windows` to export a build inside `target/godot-windows`

