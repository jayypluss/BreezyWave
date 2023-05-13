extends Node3D

var third_person_camera: Camera3D

const ZOOM_STEP := 0.5
var min_zoom := 9
var max_zoom := 22

var horizontal: float = 0
var vertical: float = 0
var v_min: float = -70 # Looking up
var v_max: float = 12 # Look down
var h_acceleration := 10
var v_acceleration := 10
var last_source := 'joystick'
var initial_position: Vector3

#var default_camera_zoom := 10

func _ready() -> void:
	third_person_camera = get_node("%Camera3D")
	initial_position = third_person_camera.position
	if third_person_camera.current:		
		if (ConfigsState.camera_distance):
			third_person_camera.position.z = ConfigsState.camera_distance
			
		if (ConfigsState.camera_far):
			third_person_camera.far = ConfigsState.camera_far
			
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# 	Prevent camera from colliding with player.
	# 	$Horizontal/Vertical/Camera3D.add_exception(get_parent())
	# 	Fetch draw distance from configuration file.

func _input(event: InputEvent) -> void:
	if third_person_camera.current:
#  if get_parent().paused: # Used to prevent camera movement when returning from a cutscene.
#    return

#	print('sensitivity: ', sensitivity)

		var zoom = get_node("%Camera3D").position.z
		
		if event is InputEventMouseMotion:
			horizontal -= event.relative.x * Settings.get_value("controls", "mouse_sensitivity")
			vertical -= event.relative.y * Settings.get_value("controls", "mouse_sensitivity")
		elif event.is_action_pressed("zoom_in") and zoom > min_zoom:
			get_node("%Camera3D").position.z -= ZOOM_STEP
			ConfigsState.camera_distance = get_node("%Camera3D").position.z
		elif event.is_action_pressed("zoom_out") and zoom < max_zoom:
			get_node("%Camera3D").position.z += ZOOM_STEP
			ConfigsState.camera_distance = get_node("%Camera3D").position.z

func _physics_process(delta: float) -> void:
	if third_person_camera.current:
	# print(vertical) # It's useful to print the current value when trying to find the proper values for 'min' and 'max'.

	# Lock "vertical" position in range [v_min, v_max].
		vertical = clamp(vertical, v_min, v_max)

	# Move camera smoothly based checked "delta * acceleration".
		$Horizontal.rotation_degrees.y = lerp($Horizontal.rotation_degrees.y, horizontal, delta * h_acceleration)
		$Horizontal/Vertical.rotation_degrees.x = lerp($Horizontal/Vertical.rotation_degrees.x, vertical, delta * v_acceleration)

func set_initial_position():
	third_person_camera.position = initial_position
