extends Node3D
class_name Spring

var player_inisde: Player
var low_multiplier:= 1.75
var high_multiplier:= 2.85

func _physics_process(_delta):
	if player_inisde:
		$BounceSoundEffect.play()
		$AnimationPlayer.play("shrink_and_expand")
		if Input.is_action_pressed("jump"):
			player_inisde.input.force_jump(high_multiplier)
		else:
			player_inisde.input.force_jump(low_multiplier)

func _on_spring_trigger_body_entered(player: Player):
	player_inisde = player

func _on_spring_trigger_body_exited(_player):
	player_inisde = null
