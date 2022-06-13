extends Control


onready var stars_collected = GameState.colorful_stars_collected.size()
onready var counter_label : Label = $HBoxContainer/Counter
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var timer : Timer = $Timer

var is_star_counter_showing : bool = false


func _ready():
	update_label()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("show_hud"):
		show_hud()
	
func on_star_collected():
	show_hud()
	update_label()

func update_label():
	stars_collected = GameState.colorful_stars_collected.size()
	counter_label.text = str(stars_collected)

func _on_Timer_timeout():
	if is_star_counter_showing:
		animation_player.play("hide")
		is_star_counter_showing = false

func show_hud():
	if !is_star_counter_showing:
		animation_player.play("show")
		is_star_counter_showing = true
		
	timer.start()
