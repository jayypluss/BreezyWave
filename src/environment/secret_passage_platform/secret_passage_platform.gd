extends KinematicBody

onready var mesh: MeshInstance = $Mesh
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_player2: AnimationPlayer = $AnimationPlayer2

var is_showing = false


func fade_in():
	if !is_showing:
		animation_player.play("fade_in")
		is_showing = true
		for child in get_children():
			if child is ColorfulStar:
				child.show()

func move_away():
	animation_player.play("move_away")
	animation_player2.play("change_colors")
