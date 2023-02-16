extends CameraState
# Rotates the camera around the character, delegating all the work to its parent state.


func unhandled_input(event: InputEvent) -> void:
	if _parent:
		if event.is_action_pressed("toggle_aim"):
			_state_machine.transition_to("Camera3D/Aim")
		else:
			_parent.unhandled_input(event)


func process(delta: float) -> void:
	if _parent:
		_parent.process(delta)
