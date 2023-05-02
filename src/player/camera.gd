extends Node3D

const ZOOM_STEP := 0.5
var min_zoom := 9
var max_zoom := 22

var horizontal: float = 0
var vertical: float = 0
var v_min: float = -70 # Looking up
var v_max: float = 12 # Look down
var h_acceleration := 10
var v_acceleration := 10

#var default_camera_zoom := 10

func _ready() -> void:
	if (ConfigsState.camera_distance):
		get_node("%Camera3D").position.z = ConfigsState.camera_distance
		
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# 	Prevent camera from colliding with player.
# 	$Horizontal/Vertical/Camera3D.add_exception(get_parent())
# 	Fetch draw distance from configuration file.

	$Horizontal/Vertical/Camera3D.far = ConfigsState.camera_far

func _input(event: InputEvent) -> void:
#  if get_parent().paused: # Used to prevent camera movement when returning from a cutscene.
#    return

	var zoom = get_node("%Camera3D").position.z
	
	if event is InputEventMouseMotion:
		horizontal -= event.relative.x * 0.5
		vertical -= event.relative.y * 0.5
	elif event.is_action_pressed("zoom_in") and zoom > min_zoom:
		get_node("%Camera3D").position.z -= ZOOM_STEP
		ConfigsState.camera_distance = get_node("%Camera3D").position.z
	elif event.is_action_pressed("zoom_out") and zoom < max_zoom:
		get_node("%Camera3D").position.z += ZOOM_STEP
		ConfigsState.camera_distance = get_node("%Camera3D").position.z

func _physics_process(delta: float) -> void:
# print(vertical) # It's useful to print the current value when trying to find the proper values for 'min' and 'max'.

# Lock "vertical" position in range [v_min, v_max].
	vertical = clamp(vertical, v_min, v_max)

# Move camera smoothly based checked "delta * acceleration".
	$Horizontal.rotation_degrees.y = lerp($Horizontal.rotation_degrees.y, horizontal, delta * h_acceleration)
	$Horizontal/Vertical.rotation_degrees.x = lerp($Horizontal/Vertical.rotation_degrees.x, vertical, delta * v_acceleration)
