with import <nixpkgs> {};
mkShell rec {
  buildInputs = [
    rustup
    libclang
    godot-headless
    gnumake
  ];
  nativeBuildInputs = [ clang ];

  LIBCLANG_PATH = "${libclang.lib}/lib";
  RUST_SRC_PATH = rust.packages.stable.rustPlatform.rustLibSrc;
  LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);
}
