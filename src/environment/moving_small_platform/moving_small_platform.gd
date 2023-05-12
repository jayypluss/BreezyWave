extends AnimatableBody3D
class_name MovingSmallPlatform

@export var duration: float = 4
@export var movement_vector: Vector3 = Vector3.ZERO

var initial_position: Vector3
var final_position: Vector3
var total_distance: float
var tween: Tween
var pressed: bool = false

func _ready() -> void:
	initial_position = position
	final_position = initial_position + movement_vector
	total_distance = initial_position.distance_to(final_position)

func start_moving():
	pressed = true
	var partial_time = calculate_distance(final_position)
	if !partial_time:
		partial_time = duration
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", final_position, partial_time)
	tween.tween_property(self, "position", initial_position, partial_time)
#	tween.chain().tween_callback(func(): print('going_back = false'); pressed = false)

func stop_moving():
	pressed = false
	var partial_time = calculate_distance(initial_position)
	if !partial_time:
		partial_time = duration
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", initial_position, partial_time)
#	tween.chain().tween_callback(func(): print('going_back = false'); pressed = false)

func calculate_distance(_desired_position: Vector3):
	var partial_distance = position.distance_to(_desired_position)
	var partial_time = (duration * partial_distance) / total_distance
	print('partial_time: ', partial_time)
	return partial_time
