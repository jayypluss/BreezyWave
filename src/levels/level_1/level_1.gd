extends Spatial

onready var player := $Player
onready var win_game_screen := $Screens/WinGameScreen
onready var game_over_screen := $Screens/GameOverScreen


func _ready():
	if OS.has_feature("standalone"):
		player.transform.origin = Vector3.ZERO
		$Music.play()
	else:
		print('entering !standalone if on level_1.gd s _ready()')
		print('Opened level_1 from editor.')


func _on_PortalTrigger_body_entered(_body : KinematicBody):
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
		get_tree().set_input_as_handled()


func _on_DyingTrigger_body_entered(body: Player):
	body.die()
#	game_over_screen.show()



func _on_MovingPlatform1_button_pressed(is_active: bool):
	$Platforms/MovingPlatform1.play_animation()
	print('received move platform signal')
