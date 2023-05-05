extends Control
class_name ActionIndicator

@onready var action_indicator_label = $MarginContainer/ActionIndicator/Panel/ActionIndicatorLabel

func show_with_text(_label: String):
	set_label(_label)
	show()


func hide_and_clear():
	hide()
	set_label('')

func set_label(_label: String):
	action_indicator_label.text = _label
