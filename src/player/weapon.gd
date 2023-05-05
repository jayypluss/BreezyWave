extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D

func _process(_delta):
	if Input.is_action_pressed("click"):
		animation_player.play("bat_hit")
		await animation_player.animation_finished
		path_follow.progress = 0
		
