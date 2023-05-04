extends Area3D
class_name Portal

signal on_finish_animation()

@onready var enter_anim_position: Node3D = $EnterAnimPosition
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var portal_2d_shader_control = $Portal2DShaderControl

var already_entered := false

func _on_body_entered(_body: Node3D):
	suck_node_into_portal(_body)


func suck_node_into_portal(_body: Node3D):	
	if !already_entered and _body is Player:
		already_entered = true
		_body.lock_movement()
		var final_pos = mesh_instance_3d.global_position
		final_pos.z -= 2
		portal_2d_shader_control.show()
		var tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).set_parallel(true)
		tween.tween_property(_body, "position", enter_anim_position.global_position, 0.5)
		tween.tween_property(_body.player_pivot, "scale", Vector3(0.643, 0.197, 3.216), 0.7)
		tween.chain().tween_property(_body, "position", final_pos, 0.2)
		tween.chain().tween_callback(
			func(): 
				emit_signal("on_finish_animation")
				_body.lock_movement()
				portal_2d_shader_control.hide()
		)
		
	
	
	
