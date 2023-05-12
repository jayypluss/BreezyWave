extends Node


var tutorial_steps: Array = []
var is_showing_tutorial_step: bool = false
var colorful_stars_collected: Dictionary = {}
var remaining_lives: int = 0
var player: Player
var hud: HUD
var global_levels_screens: GlobalLevelsScreens
var curent_level_node_name: String

var levels: Dictionary = {
	"Level1": {
		"name": "the starting path",
		"path": "res://src/levels/level_1/level_1.tscn",
		"last_level": "",
		"next_level": "Level2",
		"last_checkpoint": Vector3(0, 3, 0)
	},
	"Level2": {
		"name": "ups and downs",
		"path": "res://src/levels/level_2/level_2.tscn",
		"last_level": "Level1",
		"next_level": "Level3",
		"last_checkpoint": Vector3(0, 3, 0)
	},
	"Level3": {
		"name": "touch the skies",
		"path": "res://src/levels/level_3/level_3.tscn",
		"last_level": "Level2",
		"next_level": "Level4",
		"last_checkpoint": Vector3(0, 3, 0)
	},
	"Level4": {
		"name": "introspection",
		"path": "res://src/levels/level_4/level_4.tscn",
		"last_level": "Level3",
		"next_level": "",
		"last_checkpoint": Vector3(0, 3, 0)
	}
}


func _ready():
	restore()

func save_checkpoint(_position: Vector3):
	get_current_level_data().last_checkpoint = _position
	
func get_last_checkpoint():
	return get_current_level_data().last_checkpoint

func go_to_level(_level_node_name: String):
	get_tree().change_scene_to_file(levels[_level_node_name].path)

func has_next_level():
	return !(get_current_level_data().next_level as String).is_empty()
		
func go_to_next_level():
	if get_current_level_data().next_level:
		get_tree().change_scene_to_file(levels[get_current_level_data().next_level].path)

func get_current_level_data():
	return levels[get_current_level_node_name()]
	
func get_current_level_name():
	return levels[get_current_level_node_name()].name
	
func get_current_level_node_name():
	return get_tree().get_current_scene().name

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
