extends Spatial


func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		var random = randi() % 40 + 1
		print("Changing shader random to: ", random)
		$StaticBody.get_child(1).get_surface_material(0).set_shader_param("random_scale", random)
