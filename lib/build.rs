use gdnative_project_utils::*;
use std::{env, fs, path::Path};

fn main() -> Result<(), Box<dyn std::error::Error>> {
  let target = env::var("TARGET").unwrap();
  let classes = scan_crate("../core/src/scenes")?;

  println!("cargo:rerun-if-env-changed=FORCE");

  // Remove all generated files
  fs::remove_dir_all("../godot/libs").expect("unable to delete libs directory");
  fs::create_dir("../godot/libs").expect("unable to create libs directory");

  // Target directory hack for linux and win
  let target_dir = match &target[..] {
    "x86_64-unknown-linux-gnu" | "x86_64-pc-windows-gnu" => Some(Path::new("./target").join(target)),
    _ => None,
  };

  // Generate libs
  let mut generator = Generator::new()
    .godot_resource_output_dir("../godot/libs")
    .godot_project_dir("../");

  if let Some(target_dir) = target_dir {
    generator.with_target_dir(target_dir);
  }

  generator.build(classes)?;

  Ok(())
}
