extends CanvasLayer

onready var hidable := $Hidable

onready var value_label := $Hidable/VBoxContainer/MusicVolumeContainer/MusicVolumeLabelsContainer/MusicVolumeValueLabel



func _ready():
	toggle_visible(false)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if hidable.visible:
			toggle_visible(false)

func toggle_visible(visible: bool = !hidable.visible):
	hidable.visible = visible

func _on_MainMenu_pressed():
	toggle_visible(false)

func _on_CancelButton_pressed():
	toggle_visible(false)

func _on_MusicVolumeSlider_value_changed(value: float):
	value_label.text = str(value)
	print(value)
	
