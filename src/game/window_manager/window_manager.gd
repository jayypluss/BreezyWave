extends Node

func _input(event: InputEvent):
	if event.is_action_pressed('toggle_fullscreen'):
		var window_mode = DisplayServer.window_get_mode()
		print(window_mode)
		if window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		elif window_mode == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		get_viewport().set_input_as_handled()
