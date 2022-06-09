extends Control


onready var step: PopupDialog = $Step
onready var step_label: Label = $Step/Label

var tutorial_texts = [
    "W, A, S, D: Walking \nSPACE: Jumping \nSHIFT: Sprinting", 
    "E: Interact",
    "This is a jumping \nspring, jump on it!",
    "Hold SPACE for \nHigher Jumps"
]


func _unhandled_input(event):
    if event.is_action_pressed("interact") && GameState.is_showing_tutorial_step:
        hide_popup()

func show_next_step(tutorial_text_index: int):
    step_label.text = tutorial_texts[tutorial_text_index]
    step.popup()
    GameState.is_showing_tutorial_step = true

func _on_Player_entered_area(_player: Player, area: Area):
    var tutorial_text_index: int = int(area.name.substr(4, 5))
    show_next_step(tutorial_text_index)
    GameState.tutorial_steps.append(tutorial_text_index)

func _on_Player_exited_area(_player: Player, _area: Area):
    hide_popup()
    
func hide_popup():
    step.hide()
    GameState.is_showing_tutorial_step = false

