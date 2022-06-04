extends CanvasLayer

onready var parent_layer := $Hidable
onready var next_level_button := $Hidable/VBoxOptions/RestartLevel
onready var main_menu := $Hidable/VBoxOptions/MainMenu
onready var level_win_text := $Hidable/Label


func _exit_tree() -> void:
	toggle_paused(true)

func _on_RestartLevel_pressed():
	get_tree().paused = false
	togle_visible(false)
#	Game.restart_scene()
	Game.change_scene("res://src/levels/level_1/level_1.tscn", {
		'show_progress_bar': false
	})

func _on_MainMenu_pressed():
	toggle_paused(false)
	togle_visible(false)
	Game.change_scene("res://src/gui/menu/menu.tscn", {
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
	