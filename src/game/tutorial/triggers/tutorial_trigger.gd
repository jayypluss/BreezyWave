extends Area

signal custom_body_entered(body, area)


func _on_Area_body_exited(body):
	queue_free()


func _on_Area_body_entered(body):
	emit_signal("custom_body_entered", body, self)
	pass # Replace with function body.
