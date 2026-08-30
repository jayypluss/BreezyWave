@tool
extends StaticBody3D

@onready var spawn_point = $SpawnPoint
@onready var label = $Label
@onready var torus_mesh = $TorusMesh

var player: Player
var initial_y: float
var move_length_y: float = 2
var is_used: bool = false

func _ready():
	initial_y = torus_mesh.position.y

func _input(event: InputEvent):
	if player && event.is_action_pressed('interact'):
		save_checkpoint()

func editor_interaction_trigger():
	if Engine.is_editor_hint():
		label.toggle_expand()

func _on_interaction_area_body_entered(_body: Player):
	player = _body
	_set_action_info()
	label.expand()

func _set_action_info():
	GameState.hud.panel_control.action_indicator_control.show_with_text('Checkpoint active' if is_used else 'E to interact')

func _on_interaction_area_body_exited(_body):
	player = null
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()
	label.collapse()

func save_checkpoint():
	GameState.save_checkpoint(spawn_point.global_position)
	start_animation()
	_toggle_used(true)

func _toggle_used(used: bool):
	is_used = used
	_set_action_info()
	if used:
		label.set_text("")
	else:
		label.set_text("?")

func start_animation():
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	tween.tween_property(torus_mesh, "position:y", (initial_y + move_length_y), 1)
#	tween.tween_property(torus_mesh, "scale", Vector3(1, 1, 1), tween_duration_y)
	tween.tween_callback(func(): show())
