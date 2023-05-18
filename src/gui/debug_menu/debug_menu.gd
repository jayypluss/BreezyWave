extends Control

@onready var text_edit = $BG/TextEdit

func _ready():
	print('Debug Menu ready')

func _on_tree_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func read_input():
	if text_edit.text.begins_with('open_level.'):
		GameState.go_to_level('Level'  + text_edit.text.get_extension())
	if text_edit.text.begins_with('open.'):
		GameState.go_to_level(text_edit.text.get_extension())
	text_edit.clear()
	get_tree().paused = false
	queue_free()

func _on_gui_input(_event):
	if _event.is_action_pressed('ctrl_enter_confirm') and not _event.is_echo():
		print(text_edit.text)
		read_input()

func _on_text_edit_gui_input(_event):
	if _event.is_action_pressed('ctrl_enter_confirm') and not _event.is_echo():
		print(text_edit.text)
		read_input()
