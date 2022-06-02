tool
extends Spatial
class_name Spring


var is_inside_higher_jump_availability_area = false
var ready_to_higher_jump = false


func _physics_process(delta):
	if Input.is_action_pressed("jump") && is_inside_higher_jump_availability_area:
		ready_to_higher_jump = true

func _on_Trigger_body_entered(body):
	$BounceSoundEffect.play()
	if ready_to_higher_jump:
		body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 75 })
	else:
		body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 57.5 })

func _on_HigherJumpAvailabilityArea_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	is_inside_higher_jump_availability_area = true


func _on_HigherJumpAvailabilityArea_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	is_inside_higher_jump_availability_area = false
	ready_to_higher_jump = false

