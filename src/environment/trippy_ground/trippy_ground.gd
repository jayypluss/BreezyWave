extends Node3D


func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		var random = randi() % 40 + 1
		print("Changing shader random to: ", random)
		$StaticBody3D.get_child(1).get_surface_override_material(0).set_shader_parameter("random_scale", random)
