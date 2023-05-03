extends Area3D

@onready var interactable_area: CollisionShape3D = $InteractableArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var can_deactivate: bool = false

var player: Player
var is_active = false

signal on_button_pressed(is_active)


func _physics_process(_delta):
	if Input.is_action_just_pressed("interact") && is_instance_valid(player):
		if can_deactivate:
			if (!is_active): 
				animation_player.play("activate_button")
			else:
				animation_player.play("unactivate_button")

			is_active = !is_active

		else:
			if !is_active:
				animation_player.play("activate_button")
			is_active = true
	
		emit_signal("on_button_pressed", is_active)

func _on_PedestalButton_body_entered(body: Player):
	player = body
	GameState.hud.panel_control.action_indicator_control.show_with_text('E to interact')

func _on_PedestalButton_body_exited(_body):
	player = null
	GameState.hud.panel_control.action_indicator_control.hide_and_clear()
