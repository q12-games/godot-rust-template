use gdnative::prelude::*;
use q12_godot_helpers::{get_node, unwrap_ref};

type Owner = Node;

#[derive(NativeClass, Default)]
#[inherit(Owner)]
pub struct Example {
  count: i32,
  count_text_node: Option<Ref<Label>>,
}

#[methods]
impl Example {
  pub fn new(_owner: &Owner) -> Self {
    Self::default()
  }

  #[export]
  fn _ready(&mut self, owner: &Owner) {
    godot_print!("Ready to go");

    self.count_text_node = get_node(owner, "Text");
  }

  #[export]
  fn _process(&mut self, _owner: &Owner, _del: f32) {
    let input = Input::godot_singleton();

    if input.is_action_just_pressed("ui_up") {
      self.count += 1;
    }

    if input.is_action_just_pressed("ui_down") {
      self.count -= 1;
    }

    unwrap_ref!(self.count_text_node).map(|node| {
      node.set_text(format!("Count: {}", self.count));
    });
  }
}
