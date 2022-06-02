extends Node

var colorful_stars_collected: Dictionary = {}
var remaining_lives: int

func _ready():
	restore()

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
