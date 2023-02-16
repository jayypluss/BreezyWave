@tool
extends Node3D
class_name CameraRig
# Accessor class that gives the nodes in the scene access the player or some
# frequently used nodes in the scene itself.

signal aim_fired(target_position)

@onready var camera: Camera3D = $Camera3D
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var aim_ray: RayCast3D = $Camera3D/AimRay
@onready var aim_target: Sprite3D = $AimTarget

@onready var player: CharacterBody3D = get_tree().root.get_node_or_null('%Player')

var zoom := 0.5 : set = set_zoom

@onready var _position_start: Vector3 = position


func _ready() -> void:
	set_as_top_level(true)
	await owner.ready
	player = owner
	check_everything_is_not_null()

func check_everything_is_not_null():
	if !camera:
		print('camera is null')
	if !spring_arm:
		print('state_machine is null')
	if !aim_ray:
		print('last_position_timer is null')
	if !aim_target:
		print('last_position_timer is null')
	if !player:
		print('last_position_timer is null')

func _get_configuration_warnings() -> PackedStringArray:
	if not player:
		return PackedStringArray(["Missing player node"])
	else:
		return []

func set_zoom(value: float) -> void:
	zoom = clamp(value, 0.0, 1.0)
	if not spring_arm:
		await spring_arm.ready
	spring_arm.zoom = zoom
