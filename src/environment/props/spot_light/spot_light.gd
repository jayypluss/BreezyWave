extends SpotLight3D

@onready var spot_light_3d = $SpotLight3D

var initial_color: Color
var player_inside: Player
var tween: Tween

func _ready():
	initial_color = light_color

func _physics_process(_delta):
	if player_inside:			
		if Input.is_action_just_pressed('interact'):
			create_light_color_change_tween()
		if Input.is_action_just_released('interact'):
			if tween:
				tween.stop()
		
func _on_body_entered(_body: Node3D):
	if _body is Player:
		player_inside = _body

func _on_interaction_area_body_entered(_body):
	if _body is Player:
		player_inside = _body
		GameState.hud.panel_control.action_indicator_control.show_with_text('E to interact')

func _on_interaction_area_body_exited(_body):
	if _body is Player:
		player_inside = null
		GameState.hud.panel_control.action_indicator_control.hide_and_clear()

func create_light_color_change_tween():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(spot_light_3d, "light_color", Color.RED, 0.5)
	tween.tween_property(spot_light_3d, "light_color", Color.GREEN, 0.5)
	tween.tween_property(spot_light_3d, "light_color", Color.BLUE, 0.5)
	tween.tween_property(spot_light_3d, "light_color", initial_color, 0.5)
	tween.tween_callback(
		func(): 
			if Input.is_action_pressed("interact") and player_inside:
				create_light_color_change_tween()
	)
