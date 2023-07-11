extends Control

@onready var text_edit = $BG/TextEdit

func _on_tree_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	await get_tree().process_frame
	$BG/TextEdit.grab_focus()

func parse_input():
	if text_edit.text.begins_with('open_level.'):
		open_level(text_edit.text.get_extension())
	if text_edit.text.begins_with('open.'):
		open(text_edit.text.get_extension())
	if text_edit.text.begins_with('reset_player_position'):
		GameState.player.global_position = Vector3(0, 3, 0)
	if text_edit.text.begins_with('set_player_position.'):
		var vec = str(text_edit.text.get_extension()).split_floats(',')
		set_player_position(Vector3(vec[0], vec[1], vec[2]))
		
	text_edit.clear()
	
	self_dispose()

func _on_text_edit_gui_input(_event: InputEvent):
	if not _event.is_echo():
		if _event.is_action_pressed('ctrl_enter_confirm'):
			parse_input()
		if (_event.is_action_pressed('toggle_debug_menu') or _event.is_action_pressed('pause')):
			self_dispose()

func _on_visibility_changed():
	if visible and text_edit:
		text_edit.grab_focus()

func self_dispose():
	get_tree().paused = false
	queue_free()

func open_level(level_number: String):
	GameState.go_to_level('Level'  + level_number)

func open(scene_name: String):
	GameState.go_to_level(scene_name)

func set_player_position(_position: Vector3 = Vector3(0, 3, 0)):
	GameState.player.global_position = _position
