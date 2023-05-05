extends Control

func _on_main_menu_button_toggled(_button_pressed):
	print(get_tree().root)
	hide()
	get_tree().root.hide()
