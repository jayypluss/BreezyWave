tool
class_name Player
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

onready var camera: CameraRig = $CameraRig
#onready var skin: Mannequiny = $Mannequiny
onready var state_machine: StateMachine = $StateMachine
onready var last_position_timer = $LastPositionTimer

var last_floor_position: Vector3

func _ready():
	last_position_timer.start()

func _get_configuration_warning() -> String:
	return "Missing camera node" if not camera else ""

func die():
	if translation: 
		translation = last_floor_position

func _on_LastPositionTimer_timeout():
	if is_on_floor() && translation:
		last_floor_position = translation

	last_position_timer.start()
