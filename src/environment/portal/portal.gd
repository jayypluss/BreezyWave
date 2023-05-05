extends Area3D
class_name Portal

signal on_finish_animation()

@onready var enter_anim_position: Node3D = $EnterAnimPosition
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var portal_2d_shader_control = $Portal2DShaderControl
@onready var portal_2d_shader = $Portal2DShaderControl/Portal2DShader
@onready var player_wobble_material = preload("res://assets/material/shader_material_3d/player_wobble.tres")

var body_initial_location: Vector3
var already_entered := false
var player_inside: Player

func _input(event: InputEvent):
	if player_inside && event.is_action('interact'):
		suck_node_into_portal(player_inside)
		
func _on_body_entered(_body: Node3D):
	if _body is Player:
		player_inside = _body

func suck_node_into_portal(_player: Player):	
	if !already_entered and _player:
		body_initial_location = _player.position
		already_entered = true
		_player.lock_movement()
		
		var final_pos = mesh_instance_3d.global_position
		final_pos.z -= 4
		
		var mesh: MeshInstance3D = _player.player_mesh
		mesh.set_surface_override_material(0, player_wobble_material)
		
		_player.left_eyeball.set_surface_override_material(0, player_wobble_material)
		_player.right_eyeball.set_surface_override_material(0, player_wobble_material)

		var set_player_shader_params := func (amount): 
			mesh.get_surface_override_material(0).set_shader_parameter('amount', amount)
			mesh.get_surface_override_material(0).set_shader_parameter('speed', amount)

		portal_2d_shader_control.show()

		var set_canvas_shader_params := func (amount): 
			portal_2d_shader.material.set_shader_parameter('transparency', amount)
			
		GameState.hud.panel_control.action_indicator_control.hide_and_clear()
		GameState.hud.panel_control.simple_info_box_control.hide_and_clear()
		var tween: Tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN).set_parallel(true)
		tween.tween_method(set_canvas_shader_params.bind(), 0.01, 0.6, 1.5)
		tween.tween_method(set_player_shader_params.bind(), 0.001, 1.2, 1.0)
		tween.tween_property(_player, "position", final_pos, 1.0)
		tween.tween_interval(2)
		tween.chain().tween_callback(
			func(): 
				mesh.set_surface_override_material(0, null)
				emit_signal("on_finish_animation")
				_player.lock_movement()
#				portal_2d_shader_control.hide()
				_player.left_eyeball.set_surface_override_material(0, null)
				_player.right_eyeball.set_surface_override_material(0, null)
##				player.position = body_initial_location
#				player.lock_movement(false)
#				already_entered = false
		)


func _on_body_exited(_body):
	player_inside = null
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()


func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if _local_shape_index == 1 and player_inside:
		suck_node_into_portal(player_inside)
