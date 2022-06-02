extends KinematicBody

onready var mesh: MeshInstance = $Mesh
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_player2: AnimationPlayer = $AnimationPlayer2
onready var cinematic_animation_player: AnimationPlayer = $CinematicAnimation
onready var cinematic_camera: InterpolatedCamera = $Cinematic

var is_showing = false
var main_camera

func start_cinematics():
	main_camera = get_viewport().get_camera()
	cinematic_camera.make_current()
	cinematic_animation_player.play("move_camera")

func fade_in():
	if !is_showing:
		animation_player.play("fade_in")
		is_showing = true
		for child in get_children():
			if child is ColorfulStar:
				child.show()

func move_away():
	main_camera.make_current()
	animation_player.play("move_away")
	animation_player2.play("change_colors")

func _on_CinematicAnimation_animation_finished(anim_name: String):
	move_away()
