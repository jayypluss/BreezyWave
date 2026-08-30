@tool
extends EditorPlugin

func _enter_tree():
	set_input_event_forwarding_always_enabled()
	EditorInterface.get_selection().selection_changed.connect(_on_selection_changed)

func _exit_tree():
	EditorInterface.get_selection().selection_changed.disconnect(_on_selection_changed)
	
func _on_selection_changed():
	var selection := EditorInterface.get_selection()
	var nodes := selection.get_selected_nodes()

	if nodes.is_empty():
		return

	var node := nodes[0]
	print("Selected: ", node.name)

func _forward_3d_gui_input(camera: Camera3D, event: InputEvent) -> int:
	if is_project_action_pressed(event, "editor_trigger"):
		print("Pressed Cltr+Shift+Alt+E")
		_trigger_selected_nodes()
		return EditorPlugin.AFTER_GUI_INPUT_STOP

	return EditorPlugin.AFTER_GUI_INPUT_PASS

func is_project_action_pressed(
	event: InputEvent,
	action: StringName
) -> bool:
	if not event.is_pressed():
		return false

	var setting = ProjectSettings.get_setting("input/" + action, null)

	if setting == null:
		return false

	for configured_event: InputEvent in setting.events:
		if event.is_match(configured_event):
			return true

	return false

func _trigger_selected_nodes() -> void:

	var selection := EditorInterface.get_selection()

	for node in selection.get_selected_nodes():
		if node.has_method("editor_interaction_trigger"):
			node.editor_interaction_trigger()
			print("Triggered editor_interaction_trigger selected node: ", node)
