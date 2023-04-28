extends Area3D

@export var control: Node
@onready var label: Label3D = $StaticBody3D/Label3D
var go_up_tween: Tween
var go_down_tween: Tween
var label_initial_y: float
var initial_label_scale: Vector3
var label_move_length_y: float = 1
var label_tween_duration_y: float = 0.5

func _ready():
	label_initial_y = label.position.y
	initial_label_scale = label.scale
	if is_instance_valid(control):
		if control.has_method('_on_Player_entered_area'):
			var _ben = self.connect("body_entered", Callable(control,"_on_Player_entered_area").bind(self))
		if control.has_method('_on_Player_exited_area'):
			var _bex = self.connect("body_exited", Callable(control,"_on_Player_exited_area").bind(self))



func _on_body_entered(body):
#	label.show()
	start_moving()


func _on_body_exited(body):
#	label.hide()
	stop_moving()
	
func start_moving():
	go_up_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	go_up_tween.tween_property(label, "position:y", (label_initial_y + label_move_length_y), label_tween_duration_y)
	go_up_tween.tween_property(label, "scale", Vector3(1, 1, 1), label_tween_duration_y)

func stop_moving():
	go_down_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	go_down_tween.tween_property(label, "position:y", label_initial_y, label_tween_duration_y)
	go_down_tween.tween_property(label, "scale", initial_label_scale, label_tween_duration_y)


