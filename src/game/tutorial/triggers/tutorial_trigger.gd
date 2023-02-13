extends Area3D


func _ready():
	var tutorial_control = get_parent().get_parent()
	if is_instance_valid(tutorial_control):
		var _ben = self.connect("body_entered",Callable(tutorial_control,"_on_Player_entered_area").bind(self))
		var _bex = self.connect("body_exited",Callable(tutorial_control,"_on_Player_exited_area").bind(self))
