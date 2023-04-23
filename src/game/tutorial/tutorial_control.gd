extends Control


@onready var step: AcceptDialog = $Step

var tutorial_texts = [
	"W, A, S, D: Walking \nSPACE: Jumping \nSHIFT: Sprinting", 
	"E: Interact",
	"This is a jumping \nspring, jump checked it!",
	"Hold SPACE for \nHigher Jumps"
]

func _input(event):
	if event.is_action_pressed("interact") && GameState.is_showing_tutorial_step:
		hide_popup()
		
func show_step(text_index: int):
	step.dialog_text = tutorial_texts[text_index]
	step.popup()
	GameState.is_showing_tutorial_step = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	step.popup_centered()

func _on_Player_entered_area(_player: Player, area: Area3D):
	var text_index: int = int(area.name.substr(4, 5))
	show_step(text_index)
	GameState.tutorial_steps.append(text_index)

func _on_Player_exited_area(_player: Player, _area: Area3D):
	hide_popup()
	
func hide_popup():
	step.hide()
	GameState.is_showing_tutorial_step = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_step_confirmed():
	hide_popup()
