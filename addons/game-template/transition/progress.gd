extends Control


@onready var bar := $ProgressBar
@onready var tween := $ProgressBar/Tween
@onready var spinner_anim := $Spinner/AnimationPlayer

func _ready():
	spinner_anim.play("spinner")

func is_completed():
	return bar.value == bar.max_value
