extends StaticBody3D

@export var text: String
@onready var label: Label3D = $Label3D

var player: Player

func _unhandled_input(_event: InputEvent):
	if _event.is_action_pressed('interact') and not _event.is_echo():
		if GameState.hud.panel_control.simple_info_box_control.visible:
			GameState.hud.panel_control.simple_info_box_control.hide_and_clear()
		elif !GameState.hud.panel_control.simple_info_box_control.visible:
			if player:
				show_info()

func show_info():
	GameState.hud.panel_control.simple_info_box_control.show_with_text(text)

func _on_area_body_entered(body):
	if body is Player:
		player = body
	label.expand()
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to interact')

func _on_area_body_exited(body):
	if body is Player:
		player = null
	label.collapse()
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()
