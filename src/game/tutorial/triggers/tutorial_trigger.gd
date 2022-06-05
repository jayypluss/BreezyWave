extends Area


func _ready():
	var tutorial_control = get_parent().get_parent()
	print('tutorial_control: ', tutorial_control)
	if is_instance_valid(tutorial_control):
		self.connect("body_entered", tutorial_control, "_on_Player_entered_area", [self])
		self.connect("body_exited", tutorial_control, "_on_Player_exited_area", [self])
