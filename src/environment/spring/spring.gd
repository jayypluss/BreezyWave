@tool
extends Node3D
class_name Spring

var player_inisde: Player

func _physics_process(_delta):
	if Input.is_action_pressed("jump") and player_inisde:
		$BounceSoundEffect.play()
		$AnimationPlayer.play("shrink_and_expand")
		player_inisde.input.override_jump()

func _on_spring_trigger_body_entered(player: Player):
	player_inisde = player

func _on_spring_trigger_body_exited(_player):
	player_inisde = null
