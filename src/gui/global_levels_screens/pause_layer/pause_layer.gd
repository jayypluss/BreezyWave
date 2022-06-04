extends CanvasLayer

onready var hidable := $Hidable
onready var pause_button := $Hidable/PauseButton
onready var resume_option := $Hidable/VBoxOptions/ResumeButton
onready var main_menu_option := $Hidable/VBoxOptions/MainMenuButton
onready var label := $Hidable/InfoLabel
export var hidden: bool


func _ready():
	hidable.visible = false
	if OS.has_touchscreen_ui_hint():
		label.visible = false
	else:
		# to hide the pause_button on desktop: un-comment the next line
		# pause_button.hide()
		pass


# when the node is removed from the tree (mostly because of a scene change)
func _exit_tree() -> void:
	# disable pause
	get_tree().paused = false


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if hidable.visible:
			resume()
		else:
			pause_game()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().set_input_as_handled()


func resume():
	if !GameState.is_showing_tutorial_step:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hidable.hide()


func pause_game():
	hidable.show()
	resume_option.grab_focus()
	get_tree().paused = true


func _on_Resume_pressed():
	resume()


func _on_Main_Menu_pressed():
	Game.change_scene("res://src/gui/menu/menu.tscn", {
		'show_progress_bar': false
	})


func _on_PauseButton_pressed():
	pause_game()
