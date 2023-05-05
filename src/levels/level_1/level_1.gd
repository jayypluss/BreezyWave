extends Node3D

@onready var player : Player = $Player
@onready var win_game_screen : CanvasLayer = $Control/GlobalLevelsScreens/WinGameScreen
@onready var hud = $Control/HUD

func _ready():
	GameState.hud = hud
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.transform.origin = Vector3(0,3,0)
	if !OS.has_feature("standalone"):
		print('Opened level_test from editor')
	GameState.hud.collected_stars_info.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("toggle_mouse_captured"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#		get_viewport().set_input_as_handled()

func _on_DyingTrigger_body_entered(body: Player):
	body.die()
#	game_over_screen.show()

func _on_portal_enter_animation_ended():
	GameState.persist()
	win_game_screen._show()

func _on_portal_body_entered(_body):
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to enter the portal')
