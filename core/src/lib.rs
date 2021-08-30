pub mod scenes;

pub fn init(handle: gdnative::prelude::InitHandle) {
  handle.add_class::<scenes::example::Example>();
}

gdnative::godot_init!(init);
