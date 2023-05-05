extends CanvasLayer
class_name LevelNameIndicator

@export var level_name: String

@onready var label = $CenterContainer/Label

func _ready():
	label.text = GameState.get_current_level_name()

func present_level_name():
	show()
	GameState.player.lock_movement(true, true)
	GameState.player.lock_rotation()
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tween.tween_interval(1)
	tween.chain().tween_callback(
		func(): 
			GameState.player.lock_movement(false)
			GameState.player.lock_rotation(false)
	)
	tween.tween_property(label, "modulate", Color(1, 1, 1, 1), 1.5)
	tween.tween_interval(3)
	tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 1.5)
	
