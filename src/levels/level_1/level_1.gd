extends Node3D


@onready var player : Player = $Player

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.transform.origin = Vector3(0,3,0)
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
		get_viewport().set_input_as_handled()
