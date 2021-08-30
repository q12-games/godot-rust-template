use gdnative_project_utils::*;

fn main() -> Result<(), Box<dyn std::error::Error>> {
  let classes = scan_crate("src/scenes")?;

  Generator::new()
    .godot_resource_output_dir("../godot/libs")
    .godot_project_dir("../")
    // .build_mode(BuildMode.Debug | Release)
    .build(classes)?;

  Ok(())
}
