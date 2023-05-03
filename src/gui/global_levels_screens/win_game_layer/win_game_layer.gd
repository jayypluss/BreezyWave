extends CanvasLayer

@onready var hidable := $Hidable
@onready var next_level_button := $Hidable/VBoxOptions/NextLevel
@onready var main_menu := $Hidable/VBoxOptions/MainMenu
@onready var level_win_text := $Hidable/Label


func _ready():
	hidable.visible = false

func _exit_tree() -> void:
	toggle_paused(true)


func _on_NextLevel_pressed():
	get_tree().paused = false
	var root = get_tree().root
	var next_level: String = GameState.get_next_level(root.name)
	togle_visible(false)
#	Game.restart_scene()
#	Game.change_scene_to_file(next_level, {
#		'show_progress_bar': false
#	})
	get_tree().change_scene_to_file(next_level)

func _on_MainMenu_pressed():
	toggle_paused(false)
	togle_visible(false)
#	Game.change_scene_to_file("res://src/gui/menu/menu.tscn", {
#		'show_progress_bar': false
#	})
	get_tree().change_scene_to_file("res://src/gui/menu/menu.tscn")

func _show():
	togle_visible(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func togle_visible(setValue: bool = !hidable.visible):
	hidable.visible = setValue

func toggle_paused(paused: bool = !get_tree().paused):
	get_tree().paused = paused
	
