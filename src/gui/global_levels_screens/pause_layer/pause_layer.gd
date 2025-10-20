extends CanvasLayer
class_name PauseLayer

@onready var hidable := $Hidable
@onready var pause_button := $Hidable/PauseButton
@onready var resume_option := $Hidable/VBoxOptions/ResumeButton
@onready var main_menu_option := $Hidable/VBoxOptions/MainMenuButton
@onready var label := $Hidable/InfoLabel


func _ready():
	hidable.visible = false
	
func _exit_tree() -> void:
	get_tree().paused = false

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if hidable.visible and is_paused():
			resume()
		elif !is_paused():
			pause_game()
		get_viewport().set_input_as_handled()

func resume():
	unpause_game()
	hidable.hide()

func is_paused():
	return get_tree().paused

func pause_game():
	hidable.show()
	resume_option.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func unpause_game():
	hidable.hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Resume_pressed():
	resume()

func _on_Main_Menu_pressed():
	get_tree().change_scene_to_file("res://src/gui/main_menu/main_menu.tscn")

func _on_PauseButton_pressed():
	pause_game()
