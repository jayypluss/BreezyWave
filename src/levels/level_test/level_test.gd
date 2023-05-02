extends Node3D


@onready var player : Player = $Player
@onready var win_game_screen : CanvasLayer = $Control/GlobalLevelsScreens/WinGameScreen

# TODO should be refactored
@onready var moving_platform_1 = $Interactables/MovingPlatform1
@onready var secrete_passage_1_button = $Interactables/SecretePassage1Button
@onready var secret_passage_platform_1 = $Interactables/SecretPassagePlatform1
@onready var hud = $Control/HUD

# TODO should be refactored
var has_activate_secret_passage_1 = false

func _ready():
	GameState.hud = hud
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	player.transform.origin = Vector3(0,3,0)
	if !OS.has_feature("standalone"):
		print('Opened level_test from editor')

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

# TODO should be refactored
func _on_MovingPlatform1_button_pressed(activate: bool):
	if activate:
		moving_platform_1.start_moving()
	else:
		moving_platform_1.stop_moving()

# TODO should be refactored
func _on_SecretePassage1Button_on_button_pressed(activate: bool):
	if activate && !has_activate_secret_passage_1:
		secret_passage_platform_1.start_cinematics()
		has_activate_secret_passage_1 = true
		


func _on_PortalTrigger_body_entered(_body: CharacterBody3D):
	GameState.persist()
	win_game_screen._show()
