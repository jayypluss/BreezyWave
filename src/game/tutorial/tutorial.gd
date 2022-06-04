extends Control

onready var step: PopupDialog = $Step
onready var step_label: Label = $Step/Label
var steps_texts = [
	"W, A, S, D: Walking \nSPACE: Jumping \nSHIFT: Sprinting", 
	"E: Interact"
]

func show_next_step(step_num: int):
	step_label.text = steps_texts[step_num]
	step.popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	GameState.is_showing_tutorial_step = true

func _on_Button_pressed():
	step.hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameState.is_showing_tutorial_step = false

func _on_Step_body_entered(body: Player, area: Area):
	var step_num: int = int(area.name.substr(4, 5))
	show_next_step(step_num)
	GameState.tutorial_steps.append(step_num)
