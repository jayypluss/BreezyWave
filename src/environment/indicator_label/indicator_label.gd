extends Label3D


var go_up_tween: Tween
var go_down_tween: Tween
var initial_y: float
var initial_scale: Vector3
var move_length_y: float = 1
var tween_duration_y: float = 0.2

func _ready():
	initial_y = position.y
	initial_scale = scale

func _on_body_entered(_body):
	expand()

func _on_body_exited(_body):
	collapse()
	
func expand():
	show()
	if (is_inside_tree()):
		go_up_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		go_up_tween.tween_property(self, "position:y", (initial_y + move_length_y), tween_duration_y)
		go_up_tween.tween_property(self, "scale", Vector3(1, 1, 1), tween_duration_y)
		go_up_tween.tween_callback(func(): show())
	

func collapse():
	if (is_inside_tree()):
		go_down_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
		go_down_tween.tween_property(self, "position:y", initial_y, tween_duration_y)
		go_down_tween.tween_property(self, "scale", initial_scale, tween_duration_y)
		go_down_tween.chain().tween_callback(func(): hide())


