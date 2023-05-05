extends Node

var last_window_mode

func _ready():
	last_window_mode = DisplayServer.window_get_mode()

func _input(event: InputEvent):
	if event.is_action_pressed('toggle_fullscreen'):
		var window_mode = DisplayServer.window_get_mode()
		print('toggle_fullscreen')
		if window_mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(last_window_mode)
			
		last_window_mode = window_mode
