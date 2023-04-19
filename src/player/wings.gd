extends Node3D


@onready var skeleton: Skeleton3D = $concertina/Skeleton3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mesh: MeshInstance3D = $concertina/Skeleton3D/wings

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.get_animation('concertinaAction').loop_mode = Animation.LOOP_PINGPONG
	animation_player.speed_scale = 148
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('jump'):
		animation_player.play('concertinaAction')
#		animation_player.get_animation('concertinaAction').loop_mode = Animation.LOOP_PINGPONG
	elif Input.is_action_just_released('jump'):
		animation_player.stop()

