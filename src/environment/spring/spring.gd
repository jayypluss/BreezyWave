@tool
extends Node3D
class_name Spring


var is_inside_higher_jump_availability_area = false
var ready_to_higher_jump = false


func _physics_process(_delta):
	if is_inside_higher_jump_availability_area && Input.is_action_pressed("jump"):
		ready_to_higher_jump = true

func _on_Trigger_body_entered(body):
	$BounceSoundEffect.play()
	$AnimationPlayer.play("shrink_and_expand")
	if ready_to_higher_jump:
		body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 75 })
	else:
		body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 57.5 })

func _on_HigherJumpAvailabilityArea_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	is_inside_higher_jump_availability_area = true


func _on_HigherJumpAvailabilityArea_body_shape_exited(_body_rid, _body, _body_shape_index, _local_shape_index):
	is_inside_higher_jump_availability_area = false
	ready_to_higher_jump = false

