@tool
class_name Player
extends CharacterBody3D
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

@onready var camera: Camera3D = %Camera3D
@onready var last_position_timer = $LastPositionTimer
@onready var player_pivot = %PlayerPivot
@onready var player_mesh = %PlayerPivot/PlayerMesh
@onready var left_eyeball = $PlayerPivot/LeftEyeball
@onready var right_eyeball = $PlayerPivot/RightEyeball
@onready var input: PlayerInput = $Input

var last_floor_position: Vector3 = Vector3(0, 3, 0)


func _ready():
	GameState.player = self
	last_position_timer.start()
	GameState.player.set_meshes_visibility(%Camera3D.current)
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
#	position = Vector3(-0.515, 5.134, -267.35)
	position = last_floor_position

func _on_LastPositionTimer_timeout():
	if (is_on_floor() && get_last_slide_collision() != null 
		&& get_last_slide_collision().get_collider(0) is CSGMesh3D):
		last_floor_position = position

	last_position_timer.start()	

func lock_trough_input(lock: bool = true):
	input.lock_movement = lock

func lock_movement(lock: bool = true, except_y: bool = false):
	set_axis_lock(PhysicsServer3D.BODY_AXIS_LINEAR_X, lock)
	if !except_y:
		set_axis_lock(PhysicsServer3D.BODY_AXIS_LINEAR_Y, lock)
	set_axis_lock(PhysicsServer3D.BODY_AXIS_LINEAR_Z, lock)

func lock_rotation(lock: bool = true, except_y: bool = false):
	set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_X, lock)
	if !except_y:
		set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_Y, lock)
	set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_Z, lock)
	
func set_meshes_visibility(_visible: bool):
	player_mesh.visible = _visible
	left_eyeball.visible = _visible
	right_eyeball.visible = _visible

func _on_toggle_camera(options):
	input._on_toggle_camera(options)
	show_eyes()
	
func hide_eyes():
	left_eyeball.visible = false
	right_eyeball.visible = false
	
func show_eyes():
	left_eyeball.visible = true
	right_eyeball.visible = true
