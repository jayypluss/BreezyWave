extends Control


@onready var step: AcceptDialog = $Step
var area_player_is_inside: Area3D

var tutorial_texts = [
	"W, A, S, D: Walking \nSPACE: Jumping \nSHIFT: Sprinting", 
	"E: Interact",
	"This is a jumping \nspring, jump checked it!",
	"Hold SPACE for \nHigher Jumps"
]

func _input(event):
	if event.is_action_pressed("interact") && !GameState.is_showing_tutorial_step:
		if area_player_is_inside:
			show_step(area_player_is_inside)
	elif event.is_action_pressed("interact") && GameState.is_showing_tutorial_step:
		hide_popup()
		
func show_step(area: Area3D):
	if area.name.substr(4, 5):
		var text_index: int = int(area.name.substr(4, 5))
		if tutorial_texts.size() > text_index:
			step.dialog_text = tutorial_texts[text_index]
			step.popup()
			GameState.is_showing_tutorial_step = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
			step.popup_centered()
			GameState.tutorial_steps.append(text_index)

func _on_Player_entered_area(_player: Player, area: Area3D):
	area_player_is_inside = area

func _on_Player_exited_area(_player: Player, _area: Area3D):
	area_player_is_inside = null
	
func hide_popup():
	step.hide()
	GameState.is_showing_tutorial_step = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_step_confirmed():
	hide_popup()
