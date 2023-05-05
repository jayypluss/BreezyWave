extends Control
class_name SimpleInfoBox

@onready var label: Label = $MarginContainer/PanelContainer/Panel/Box/MarginContainer/Label
@onready var button: Button = $MarginContainer/PanelContainer/Panel/Box/Button

func show_with_text(_label_text: String, _button_text: String = 'Ok (E)'):
	set_label(_label_text)
	set_button_label(_button_text)
	show()

func hide_and_clear():
	hide()
	label.set_text('')

func set_label(_label: String):
	label.set_text(_label)

func set_button_label(_text: String):
	button.set_text(_text)
