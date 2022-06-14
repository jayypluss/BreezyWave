extends CanvasLayer

onready var hidable := $Hidable


func _ready():
	toggle_visible(false)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if hidable.visible:
			toggle_visible(false)
		
func toggle_visible(visible: bool = !hidable.visible):
	hidable.visible = visible

func _on_CancelButton_pressed():
	toggle_visible(false)
