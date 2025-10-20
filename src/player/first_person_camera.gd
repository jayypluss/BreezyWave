extends Camera3D

const ZOOM_STEP := 0.5
var min_zoom := 9
var max_zoom := 22

var horizontal: float = 0
var vertical: float = 0
var v_min: float = -70 # Looking down
var v_max: float = 85 # Look up
var h_acceleration := 40
var v_acceleration := 40
var last_source := 'joystick'

var initial_position: Vector3

#var default_camera_zoom := 10

func _ready() -> void:
	initial_position = position
	if current:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if current:
		if event is InputEventMouseMotion:
			horizontal -= event.relative.x * Settings.get_value("controls", "fp_mouse_sensitivity")
			vertical -= event.relative.y * Settings.get_value("controls", "fp_mouse_sensitivity")

func _physics_process(delta: float) -> void:
	if current:
		# print(vertical) # It's useful to print the current value when trying to find the proper values for 'min' and 'max'.

		# Lock "vertical" position in range [v_min, v_max].
		vertical = clamp(vertical, v_min, v_max)

		# Move camera smoothly based checked "delta * acceleration".
		rotation_degrees.y = lerp(rotation_degrees.y, horizontal, delta * h_acceleration)
		rotation_degrees.x = lerp(rotation_degrees.x, vertical, delta * v_acceleration)

func set_initial_position():
	position = initial_position
