with import <nixpkgs> {};
mkShell rec {
  buildInputs = [
    rustup
    libclang
    godot-headless
    gnumake
  ] ++ (
    with pkgsCross.mingwW64.windows; [ mingw_w64_pthreads pthreads ] # pthreads
  );

  nativeBuildInputs = [ clang pkgsCross.mingwW64.stdenv.cc ];

  LIBCLANG_PATH = "${libclang.lib}/lib";
  RUST_SRC_PATH = rust.packages.stable.rustPlatform.rustLibSrc;
  LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);
}
