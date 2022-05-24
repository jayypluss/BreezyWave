extends CanvasLayer

onready var parent_layer := $ParentLayer
onready var next_level_button := $ParentLayer/Pause/VBoxOptions/NextLevel
onready var main_menu := $ParentLayer/Pause/VBoxOptions/MainMenu
onready var level_win_text := $ParentLayer/LevelWinText


func _ready():
	pass


# when the node is removed from the tree (mostly because of a scene change)
func _exit_tree() -> void:
	# disable pause
	get_tree().paused = false


func _on_NextLevel_pressed():
	parent_layer.visible = false
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func _on_MainMenu_pressed():
	parent_layer.visible = false
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func win():
	parent_layer.visible = true
	get_tree().paused = true
