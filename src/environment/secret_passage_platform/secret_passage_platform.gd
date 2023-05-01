extends Node3D

@export var duration: float = 4
@export var move_vector: Vector3 = Vector3(0, 0, 0)

@onready var cinematic_animation_player: AnimationPlayer = $CinematicAnimation
@onready var cinematic_camera: Camera3D = $Cinematic
@onready var moving_platform_mesh = $MovingPlatform/Mesh
@onready var leading_path_platform_mesh = $LeadingPathPlatform/Mesh
@onready var moving_platform = $MovingPlatform

var main_camera: Camera3D
var is_showing = false
var initial_pos: Vector3
var final_pos: Vector3


func _ready() -> void:
	initial_pos = position
	final_pos = position + move_vector
	
func start_cinematics():
	main_camera = get_viewport().get_camera_3d()
	cinematic_camera.make_current()
	cinematic_animation_player.play("move_camera")

func start_moving():
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(moving_platform, "position", move_vector, duration)

func fade_in():
	if !is_showing:
		# TODO use tween
		var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		tween.tween_property(moving_platform_mesh, "surface_material_override/0:albedo_color", Color('6d3d3b'), 2)
		tween.tween_property(leading_path_platform_mesh, "surface_material_override/0:albedo_color", Color('6d3d3b'), 2)
		is_showing = true
		for child in get_children():
			if child is ColorfulStar:
				child.show()

func _on_CinematicAnimation_animation_finished(_anim_name: String):
	main_camera.make_current()
	start_moving()
