extends Spatial

onready var animation_player: AnimationPlayer = $AnimationPlayer


func start_moving():
    animation_player.play("move")
    animation_player.playback_active = true

func stop_moving():
    animation_player.playback_active = false
