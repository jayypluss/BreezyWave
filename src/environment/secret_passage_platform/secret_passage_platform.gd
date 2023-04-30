extends CharacterBody3D

@onready var fade_in_animation_player: AnimationPlayer = $FadeInAnimationPlayer
@onready var animation_player2: AnimationPlayer = $AnimationPlayer2
@onready var cinematic_animation_player: AnimationPlayer = $CinematicAnimation
@onready var cinematic_camera: Camera3D = $Cinematic

var is_showing = false
var main_camera

func start_cinematics():
	main_camera = get_viewport().get_camera_3d()
	cinematic_camera.make_current()
	cinematic_animation_player.play("move_camera")

func fade_in():
	if !is_showing:
		# TODO use tween
		fade_in_animation_player.play("fade_in")
		is_showing = true
		for child in get_children():
			if child is ColorfulStar:
				child.show()

func move_away():
	main_camera.make_current()
	# TODO use tween
	#animation_player.play("move_away")
	animation_player2.play("change_colors")

func _on_CinematicAnimation_animation_finished(_anim_name: String):
	move_away()
