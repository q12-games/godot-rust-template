use gdnative::prelude::*;

type Owner = Node;

#[derive(NativeClass, Default)]
#[inherit(Owner)]
pub struct Example {
  count: i32,
}

#[methods]
impl Example {
  pub fn new(_owner: &Owner) -> Self {
    Self::default()
  }

  #[export]
  fn _ready(&self, _owner: &Owner) {
    godot_print!("Node is loaded and ready to go");
  }
}
