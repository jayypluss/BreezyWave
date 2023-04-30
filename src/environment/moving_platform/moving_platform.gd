extends AnimatableBody3D
class_name MovingPlatform

@export var duration: float = 4
@export var move_z: float = -1

var initial_z: float
var final_z: float
var tween: Tween

func _ready() -> void:
	initial_z = position.z
	final_z = position.z + move_z
  

func start_moving():
	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "position:z", final_z, duration)
	tween.tween_property(self, "position:z", initial_z, duration)

func stop_moving():
	tween.stop()
