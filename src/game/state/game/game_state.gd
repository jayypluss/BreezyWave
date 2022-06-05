extends Node

var tutorial_steps: Array = []
var is_showing_tutorial_step: bool = false
var colorful_stars_collected: Dictionary = {}
var remaining_lives: int = 0
var levels: Array = []
var current_level_name: String = ""

func _ready():
	restore()

func get_next_level(_last_level: String):
	return "res://src/levels/level_2/level_2.tscn"


func persist():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(colorful_stars_collected))
	save_game.close()

func restore():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	save_game.open("user://savegame.save", File.READ)
	
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		# Now we set the remaining variables.
		for key in node_data.keys():
			colorful_stars_collected[key] = node_data[key]

	save_game.close()
