extends Node


var tutorial_steps: Array = []
var is_showing_tutorial_step: bool = false
var colorful_stars_collected: Dictionary = {}
var remaining_lives: int = 0
var levels: Array = []
var current_level_name: String = ""
var player
var camera_distance = 20

func _ready():
	restore()

func get_next_level(_last_level: String):
	return "res://src/levels/level_2/level_2.tscn"

func persist():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_line(JSON.stringify(colorful_stars_collected))
	save_game.close()

func restore():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	if not save_game:
		return # Error! We don't have a save to load.
	
	while save_game.get_position() < save_game.get_length():
		# Get the saved dictionary from the next line in the save file
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_game.get_line())
		var node_data = test_json_conv.get_data()

		# Now we set the remaining variables.
		for key in node_data.keys():
			colorful_stars_collected[key] = node_data[key]

	save_game.close()
