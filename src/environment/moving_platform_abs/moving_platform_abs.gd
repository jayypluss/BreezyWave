extends Node3D

@onready var animation_player = $AnimationPlayer
var move_animation: Animation
var translation_track_idx: int

@export var move_value_vector: Vector3 = Vector3.ZERO
@export var path_time: float = 5.0
@export var wait_time: float = 1.5


func _ready():
    move_animation = animation_player.get_animation("move")
    translation_track_idx = move_animation.find_track("CharacterBody3D:position")
    if translation_track_idx == -1:
        translation_track_idx = 0
    move_animation.length = path_time + wait_time
    move_animation.track_insert_key(translation_track_idx, 0.0, Vector3.ZERO)
    move_animation.track_insert_key(translation_track_idx, wait_time, Vector3.ZERO)
    move_animation.track_insert_key(translation_track_idx, path_time - wait_time, move_value_vector)
    move_animation.track_insert_key(translation_track_idx, path_time, move_value_vector)

func move():
    animation_player.play("move")
    animation_player.playback_active = true

func stop_moving():
    animation_player.playback_active = false
