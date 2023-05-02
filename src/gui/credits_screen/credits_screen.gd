extends CanvasLayer

@onready var hidable := $Hidable


func togle_visible(toggleValue: bool = !hidable.visible):
	hidable.visible = toggleValue

func _on_MainMenu_pressed():
	togle_visible(false)
