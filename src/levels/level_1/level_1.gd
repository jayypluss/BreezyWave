extends Node3D

# This level has 156 stars	

@onready var player : Player = $Player
@onready var win_game_screen : CanvasLayer = $GlobalLevelsScreens/WinGameScreen
@onready var game_over_screen : CanvasLayer= $GlobalLevelsScreens/GameOverScreen
@onready var music : AudioStreamPlayer = $Music
@onready var moving_platform_1 : Node3D = $Interactables/MovingPlatform1
@onready var moving_platform_2 : Node3D = $Interactables/MovingPlatformAbs
@onready var secret_passage_platform_1 : CharacterBody3D = $Interactables/SecretPassagePlatform1

var has_activate_secret_passage_1 = false


func _ready():
	GameState.current_level_name = self.name
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if OS.has_feature("standalone"):
		player.transform.origin = Vector3(0,3,0)
		music.play()
	else:
		print('entering !standalone if checked level_1.gd s _ready()')
		print('Opened level_1 from editor.')


func _on_PortalTrigger_body_entered(_body : CharacterBody3D):
	GameState.persist()
	win_game_screen.show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("toggle_mouse_captured"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_viewport().set_input_as_handled()


func _on_DyingTrigger_body_entered(body: Player):
	body.die()
#	game_over_screen.show()



func _on_MovingPlatform1_button_pressed(activate: bool):
	if activate:
		moving_platform_1.start_moving()
	else:
		moving_platform_1.stop_moving()


func _on_SecretePassage1Button_on_button_pressed(activate: bool):
	if activate && !has_activate_secret_passage_1:
		secret_passage_platform_1.start_cinematics()
		has_activate_secret_passage_1 = true
		


func _on_MovingPlatform1Button2_on_button_pressed(activate: bool):
	if activate:
		moving_platform_2.move()
	else:
		moving_platform_2.stop_moving()

