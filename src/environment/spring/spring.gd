tool
extends Spatial
class_name Spring



func _on_Trigger_body_entered(body):
	if body.name == "Player":
		$BounceSoundEffect.play()
		if Input.is_action_pressed("jump"):
			body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 75 })
		else:
			body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 57.5 })
