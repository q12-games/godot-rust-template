use gdnative::prelude::*;
use godot_testicles::*;

testicles! {
  fn render_without_errors() {
    d!("render");
    let root = get_root_node()?;

    // Add label
    let node = node!(Node, {}, |node: TRef<Node>| node.set_script(get_script("Example")), [
      node!(Label, { name: "Text", text: "Count: 0" }, [])
    ]);

    root.add_child(node, false);

    process_frame(&node);
  }

  fn counter() {
    let input = Input::godot_singleton();
    let root = get_root_node()?;

    // Add label
    let label = node!(Label, { name: "Text", text: "Count: 0" }, []);
    let node = node!(Node, {}, |node: TRef<Node>| node.set_script(get_script("Example")), [ label ]);

    root.add_child(node, false);

    d!("initial count text");
    process_frame(&node);
    expect!(label.text()).to_equal("Count: 0".into())?;

    d!("count text after pressing up");
    input.action_press("ui_up", 1.0);
    process_frame(&node);
    expect!(label.text()).to_equal("Count: 1".into())?;
    process_frame(&node);
    expect!(label.text()).to_equal("Count: 2".into())?;
    input.action_release("ui_up");

    d!("count text after pressing down");
    input.action_press("ui_down", 1.0);
    process_frame(&node);
    expect!(label.text()).to_equal("Count: 1".into())?;
    process_frame(&node);
    expect!(label.text()).to_equal("Count: 0".into())?;
    input.action_release("ui_down");
  }
}
