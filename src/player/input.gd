extends Node

@export var walk_speed := 14.0
@export var run_speed := 50.0

@export var jump_impulse := 45.0
@export var fall_acceleration := 95.0

@export var glide_velocity_multiplier := 0.15

var has_double_jumped := false
var paused := false
var is_jumping := false

var is_gliding := false

@onready var player: Player

# Starts as "forward", might behave weird depending checked spawn direction.
var last_direction := Vector3(0,0,-1)

#var velocity = Vector3.ZERO
var speed = 0

func _ready():
	player = self.owner

func _physics_process(delta: float) -> void:		
	if paused: # Used to prevent movement during a cutscene.
		return
	
	# Get direction vector based checked input.
	var direction = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
	)
	
#	# Rotate direction based checked camera.
	var horizontal_rotation = %CameraPivot/Horizontal.global_transform.basis.get_euler().y
	direction = direction.rotated(Vector3.UP, horizontal_rotation).normalized()
	
	if direction != Vector3.ZERO: # Player is moving.
		direction = direction.normalized()
		
		%PlayerPivot.look_at(player.position + direction, Vector3.UP)
		
		if Input.is_action_pressed("sprint"): # Running.
			speed = run_speed
		else: # Walking.
			speed = walk_speed
	
	if not is_jumping and Input.is_action_pressed("jump"): # Single jump.
		player.velocity.y = jump_impulse
		is_jumping = true
		last_direction = direction
	elif player.is_on_floor() and player.get_slide_collision_count() > 0: # Reset both jumps.
		is_jumping = false
	
	if (Input.is_action_pressed("jump") && player.velocity.y < 0): # Glide
		is_gliding = true
		has_double_jumped = true
		player.velocity.y -= fall_acceleration * glide_velocity_multiplier * delta
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		is_gliding = false
		player.velocity.y -= fall_acceleration * delta
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
		
	# Assign move_and_slide to velocity prevents the velocity from accumulating.
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector3.UP)
	player.move_and_slide()
	player.velocity = player.velocity
