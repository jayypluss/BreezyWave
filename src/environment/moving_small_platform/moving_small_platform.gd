extends AnimatableBody3D
class_name MovingSmallPlatform

@export var duration: float = 4
@export var movement_vector: Vector3 = Vector3.ZERO

var initial_position: Vector3
var final_position: Vector3
var tween: Tween
var going_back: bool = false

func _ready() -> void:
	initial_position = position
	final_position = initial_position + movement_vector

func start_moving():
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	if not going_back:
		tween.tween_property(self, "position", final_position, duration)
		tween.chain().tween_callback(func(): print('going_back = true'); going_back = true)
	tween.tween_property(self, "position", initial_position, duration)
	tween.chain().tween_callback(func(): print('going_back = false'); going_back = false)

func stop_moving():
	tween.stop()
