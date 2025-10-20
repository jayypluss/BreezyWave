extends Node

var last_window_mode
var screenshot_path = "user://screenshot-test.png"
var debug_menu_node = preload("res://src/gui/debug_menu/debug_menu.tscn")

func _ready():
	last_window_mode = DisplayServer.window_get_mode()

func _input(event: InputEvent):
	if event.is_action_pressed('toggle_fullscreen'):
		var window_mode = DisplayServer.window_get_mode()
		if window_mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(last_window_mode)
			
		last_window_mode = window_mode
	
	if event.is_action_pressed('screenshot'):
		var img = get_viewport().get_texture().get_image()
		img.save_png(screenshot_path)
		
	if event.is_action_pressed('toggle_debug_menu'):
		var debug_menu_node_instance = debug_menu_node.instantiate()
		print(get_tree().get_current_scene())
		get_tree().get_current_scene().add_child(debug_menu_node_instance)
