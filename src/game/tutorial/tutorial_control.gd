extends Control

var area_player_is_inside: Area3D

var tutorial_texts = [
	"W, A, S, D: Walking \nSPACE: Jumping",
	"SHIFT: Sprinting",
	"Enter the portal to finish the level",
	"Buttons can trigger different actions, hop on the platform and try it out!",
	"You can save your progress in Checkpoints",
	"Interact with the hanging rope to slide down",
	"This is a jumping spring, jump on it and checked it!",
	"Hold SPACE for \nHigher Jumps"
]

func _input(event):
	if event.is_action_pressed("interact"):
		if (!GameState.hud.panel_control.simple_info_box_control.visible 
			and area_player_is_inside != null):
				show_step(area_player_is_inside)
		else:
			GameState.hud.panel_control.simple_info_box_control.hide_and_clear()
		
func show_step(area: Area3D):
	if area.name.substr(4, 5):
		var text_index: int = int(area.name.substr(4, 5))
		if tutorial_texts.size() > text_index:
			GameState.hud.panel_control.simple_info_box_control.show_with_text(tutorial_texts[text_index])
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#			get_tree().paused = true
			GameState.tutorial_steps.append(text_index)

func _on_Player_entered_area(_player: Player, area: Area3D):
	area_player_is_inside = area

func _on_Player_exited_area(_player: Player, _area: Area3D):
	area_player_is_inside = null
	GameState.hud.panel_control.simple_info_box_control.hide_and_clear()
