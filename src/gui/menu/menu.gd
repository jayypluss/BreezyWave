extends Control

#export (PackedScene) var new_game_scene

func _ready():
	$Version/GameVersion.text = ProjectSettings.get_setting("application/config/version")
	$Version/GodotVersion.text = "Godot %s" % Engine.get_version_info().string
	# needed for gamepads to work
	$VBoxContainer/PlayButton.grab_focus()
	if OS.has_feature('HTML5'):
		$VBoxContainer/ExitButton.queue_free()
			
	if !OS.has_feature("standalone"):
		print('entering !standalone if on menu.gd s _ready()')
		yield(get_tree().create_timer(0.5), "timeout")
		Game.change_scene("res://src/levels/level_1/level_1.tscn", { show_progress_bar = true })



func _on_PlayButton_pressed() -> void:
	var params = {
		show_progress_bar = true,
		"a_number": 10,
		"a_string": "Ciao mamma!",
		"an_array": [1, 2, 3, 4],
		"a_dict": {
			"name": "test",
			"val": 15
		},
	}
#	if OS.has_feature('HTML5'):
	Game.change_scene("res://src/levels/level_1/level_1.tscn", params)
#	else:
#		Game.change_scene(new_game_scene.get_path(), params)


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		yield(transitions.anim, "animation_finished")
		yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()
