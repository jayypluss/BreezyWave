extends CanvasLayer

onready var hidable := $Hidable
onready var main_menu := $Hidable/MainMenu


func togle_visible(visible: bool = !hidable.visible):
	hidable.visible = visible


func _on_MainMenu_pressed():
	togle_visible(false)
