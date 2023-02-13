@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: CameraRig = $CameraRig
#onready var skin: Mannequiny = $Mannequiny
@onready var state_machine: StateMachine = $StateMachine
@onready var last_position_timer = $LastPositionTimer

var last_floor_position: Vector3

func _ready():
	last_position_timer.start()

func _get_configuration_warnings() -> PackedStringArray:
	return PackedStringArray(["Missing camera node"]) if not camera else PackedStringArray([""])

func die():
	if position: 
		position = last_floor_position

func _on_LastPositionTimer_timeout():
	if is_on_floor() && get_last_slide_collision().collider is StaticBody3D:
			last_floor_position = position

	last_position_timer.start()
