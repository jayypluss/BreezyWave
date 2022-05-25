extends CanvasLayer

onready var parent_layer := $ParentLayer
onready var next_level_button := $ParentLayer/VBoxOptions/NextLevel
onready var main_menu := $ParentLayer/VBoxOptions/MainMenu
onready var level_win_text := $ParentLayer/LevelWinText


func _exit_tree() -> void:
	toggle_paused(true)


func _on_NextLevel_pressed():
	get_tree().paused = false
	togle_visible(false)
#	Game.restart_scene()
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func _on_MainMenu_pressed():
	toggle_paused(false)
	togle_visible(false)
	Game.change_scene("res://scenes/menu/menu.tscn", {
		'show_progress_bar': false
	})

func show():
	togle_visible(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func togle_visible(visible: bool = !parent_layer.visible):
	parent_layer.visible = visible

func toggle_paused(paused: bool = !get_tree().paused):
	get_tree().paused = paused
	
