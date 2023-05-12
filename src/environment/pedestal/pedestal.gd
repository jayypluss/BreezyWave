extends Area3D

@export var control: Node
@onready var label: Label3D = $StaticBody3D/Label3D

func _ready():
	if is_instance_valid(control):
		if control.has_method('_on_Player_entered_area'):
			var _ben = self.connect("body_entered", Callable(control,"_on_Player_entered_area").bind(self))
		if control.has_method('_on_Player_exited_area'):
			var _bex = self.connect("body_exited", Callable(control,"_on_Player_exited_area").bind(self))

func _on_body_entered(_body):
	label.expand()
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to interact')

func _on_body_exited(_body):
	label.collapse()
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()
