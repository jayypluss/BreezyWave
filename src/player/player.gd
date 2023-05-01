@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %Camera3D
@onready var last_position_timer = $LastPositionTimer

var last_floor_position: Vector3

func _ready():
	GameState.player = self
	last_position_timer.start()
	check_everything_is_not_null()

func check_everything_is_not_null():
	if !camera:
		print('camera is null')
	if !last_position_timer:
		print('last_position_timer is null')

func _get_configuration_warnings() -> PackedStringArray:
	if not camera:
		return PackedStringArray(["Missing camera node"])
	else:
		return []

func die():
	if position:
		position = last_floor_position

func _on_LastPositionTimer_timeout():
	if is_on_floor() && get_last_slide_collision().get_collider(0) is CSGMesh3D:
		last_floor_position = position

	last_position_timer.start()	

