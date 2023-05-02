extends Control


@onready var stars_collected = GameState.colorful_stars_collected.size()
@onready var counter_label : Label = $HBoxContainer/Counter
@onready var timer : Timer = $Timer

var is_star_counter_showing : bool = false


func _ready():
	update_label()
	
func on_star_collected():
	update_label()

func update_label():
	if !is_star_counter_showing:
		var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position:y", position.y + 80, 0.5)
#		tween.chain().tween_callback(func(): print('going_back = true'); going_back = true)
#		animation_player.play("show")
		is_star_counter_showing = true
		
	timer.start()
	stars_collected = GameState.colorful_stars_collected.size()
	counter_label.text = str(stars_collected)

func _on_Timer_timeout():
	if is_star_counter_showing:
		var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position:y", position.y - 80, 0.5)
#		animation_player.play("hide")
		is_star_counter_showing = false
