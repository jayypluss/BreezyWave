extends Node3D


@onready var player : Player = $Player
@onready var win_game_screen : CanvasLayer = $Control/GlobalLevelsScreens/WinGameScreen
@onready var hud = $Control/HUD


func _ready():
	GameState.hud = hud
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if OS.has_feature("editor"):
		print('Opened level_3 from editor')
#		player.transform.origin = GameState.get_last_checkpoint()
#		$Music.play()
	else:
		player.transform.origin = GameState.get_last_checkpoint()
		$Music.play()
#	GameState.hud.collected_stars_info.show()
	if GameState.hud.collected_stars_info: 
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
#	body.die()
	player.transform.origin = GameState.get_last_checkpoint()

func _on_portal_enter_animation_ended():
	GameState.persist()
	win_game_screen._show()

func _on_portal_body_entered(_body):
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to enter the portal')
