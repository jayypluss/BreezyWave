extends Control

@onready var action_indicator_label = $ActionIndicator/ActionIndicatorLabel
@onready var action_indicator = $ActionIndicator

func set_label(label: String):
	action_indicator_label.text = label
