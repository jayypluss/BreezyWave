extends StaticBody3D

@export var rope: ROPE_SIZE = ROPE_SIZE.TEN

@onready var upper_starting_point = $UpperStartingPoint
@onready var end_of_rope = $EndOfRope


var player: Player
var listen_to_collision := false
var end_of_rope_collision_positions := {
	10: Vector3(2.5, -8.1, 0),
	25: Vector3(2.5, -23.1, 0),
	50: Vector3(2.5, -48.15, 0)
}
var passed_end_of_rope_collision := false

enum ROPE_SIZE {TEN = 10, TWENTY_FIVE = 25, FIFTY = 50}

func _physics_process(_delta):
	if listen_to_collision and GameState.player.is_on_floor():
		listen_to_collision = false
		GameState.player.lock_trough_input(false)
			
	if Input.is_action_just_pressed("interact") && is_instance_valid(player):
		player.lock_trough_input(true)
		listen_to_collision = true
		player.global_position = upper_starting_point.global_position

func _ready():
	show_corresponding_rope()

func show_corresponding_rope():
	get_node('RopeMesh' + str(rope) + 'M').show()
#	end_of_rope.position = end_of_rope_collision_positions[rope]

func _on_area_3d_body_entered(_body: Player):
	player = _body
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to interact')

func _on_area_3d_body_exited(_body):
	player = null
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()


func _on_end_of_rope_body_entered(_body):
	GameState.player.lock_trough_input(false)
