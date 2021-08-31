use godot_testicles::build::*;

fn main() -> std::io::Result<()> {
  setup(Config {
    godot_cmd: "godot-headless",
    test_script_path: "./run-tests.sh",
    gdnlib_path: "res://test/game-test.gdnlib",
  })
}
