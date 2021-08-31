pub mod example;

pub fn init(handle: gdnative::prelude::InitHandle) {
  handle.add_class::<example::Example>();
}
