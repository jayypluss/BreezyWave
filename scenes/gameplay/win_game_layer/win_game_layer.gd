extends CanvasLayer

onready var parent_layer := $ParentLayer
onready var next_level_button := $ParentLayer/VBoxOptions/NextLevel
onready var main_menu := $ParentLayer/VBoxOptions/MainMenu
onready var level_win_text := $ParentLayer/LevelWinText


func _exit_tree() -> void:
	pause()


func _on_NextLevel_pressed():
	get_tree().paused = false
	hide()
#	Game.restart_scene()
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func _on_MainMenu_pressed():
	get_tree().paused = false
	hide()
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func win():
	show()
	get_tree().paused = true

func hide():
	parent_layer.visible = false
	
func show():
	parent_layer.visible = true
	
func pause():
	get_tree().paused = false
	
