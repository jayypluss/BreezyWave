extends Control

#export (PackedScene) var new_game_scene

@onready var buttons_container := $ButtonsContainer
@onready var start_button := $ButtonsContainer/StartButton
@onready var credits_button := $ButtonsContainer/CreditsButton
@onready var exit_button := $ButtonsContainer/ExitButton


func _ready():
	$Version/GameVersion.text = ProjectSettings.get_setting("application/config/version")
	$Version/GodotVersion.text = "Godot %s" % Engine.get_version_info().string
	# needed for gamepads to work
	start_button.grab_focus()
	if OS.has_feature('HTML5'):
		exit_button.queue_free()
			
	if OS.has_feature("standalone"):
		$Music.play()
		
	if !OS.has_feature("standalone"):
		print('entering !standalone if checked menu.gd s _ready()')
		await get_tree().create_timer(0.5).timeout
		Game.change_scene_to_file("res://src/levels/level_1/level_1.tscn", { show_progress_bar = true })



func _on_PlayButton_pressed() -> void:
	var params = {
		"show_progress_bar": true,
		"a_number": 10,
		"a_string": "Ciao mamma!",
		"an_array": [1, 2, 3, 4],
		"a_dict": {
			"name": "test",
			"val": 15
		},
	}
#	if OS.has_feature('HTML5'):
	Game.change_scene_to_file("res://src/levels/level_1/level_1.tscn", params)
#	else:
#		Game.change_scene_to_file(new_game_scene.get_path(), params)


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		await transitions.anim.animation_finished
		await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_CreditsButton_pressed():
	$CreditsScreen.togle_visible(true)
