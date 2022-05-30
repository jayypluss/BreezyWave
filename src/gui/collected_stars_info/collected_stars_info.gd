extends Control


onready var stars_collected = GameState.colorful_stars_collected.size()
onready var counter_label : Label = $HBoxContainer/Counter
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var timer : Timer = $Timer
var is_star_counter_showing : bool = false

func _ready():
	update_label()
	
func on_star_collected():
	update_label()


func update_label():
	if !is_star_counter_showing:
		animation_player.play("show")
		is_star_counter_showing = true
		
	timer.start()
	stars_collected = GameState.colorful_stars_collected.size()
	counter_label.text = str(stars_collected)


func _on_Timer_timeout():
	if is_star_counter_showing:
		animation_player.play("hide")
		is_star_counter_showing = false
		
