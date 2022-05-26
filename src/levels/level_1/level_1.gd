extends Spatial

func _ready():
	if OS.has_feature("standalone"):
		print('Opening level_1 in debug mode.')
		$Player.transform.origin = Vector3.ZERO



func _on_PortalTrigger_body_entered(body : KinematicBody):
	print('body entered PortalTrigger: ', body)
	if body.name == "Player":
		$WinGameScreen.show()


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


func _on_DyingTrigger_body_entered(body):
	print('body entered DyingTrigger: ', body)
	if body.name == "Player":
		$WinGameScreen.show()
