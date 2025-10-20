extends Control

func _on_main_menu_button_pressed():
	hide()
	if get_parent() is MenuPages:
		get_parent().hide()
