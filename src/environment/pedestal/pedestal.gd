extends Area3D

@export var control: Node
@onready var label: Label3D = $StaticBody3D/Label3D
var go_up_tween: Tween
var go_down_tween: Tween
var label_initial_y: float
var label_move_length_y: float = 1
var label_tween_duration_y: float = 0.5

func _ready():
	label_initial_y = label.position.y
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
	if go_down_tween:
		go_down_tween.stop()
		go_down_tween.kill()
#		go_down_tween = null
	if go_up_tween:
		go_up_tween.stop()
		go_up_tween.kill()
#		go_up_tween = null
	go_up_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	go_up_tween.tween_property(label, "position:y", (label_initial_y + label_move_length_y), label_tween_duration_y)
	go_up_tween.tween_property(label, "font_size", 1500, label_tween_duration_y)
	go_up_tween.tween_property(label, "outline_size", 24, label_tween_duration_y)

func stop_moving():
	if go_up_tween:
		go_up_tween.stop()
		go_up_tween.kill()
#		go_up_tween = null
	var current_label_y = label.position.y
	if go_down_tween:
		go_down_tween.stop()
		go_down_tween.kill()
#		go_down_tween = null
	go_down_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	go_down_tween.tween_property(label, "position:y", label_initial_y, label_tween_duration_y)
	go_down_tween.tween_property(label, "font_size", 1, label_tween_duration_y)
	go_down_tween.tween_property(label, "outline_size", 1, label_tween_duration_y)


