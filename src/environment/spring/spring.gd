tool
extends Spatial
class_name Spring



func _on_Trigger_body_entered(body):
	print('_on_Trigger_body_entered')
	if body.name == "Player":
		print('player entered trigger')
		body.state_machine.transition_to("Move/Air", { velocity = Vector3.ZERO, jump_impulse = 75 })
