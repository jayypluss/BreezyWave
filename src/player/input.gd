extends Node

@onready var player: Player
@onready var dash_effect: GPUParticles3D = $"../PlayerPivot/Effects/DashEffect"
@onready var dash_timer = $"../PlayerPivot/Effects/DashTimer"

@export var walk_speed := 14.0
@export var run_speed := 50.0
@export var jump_impulse := 45.0
@export var dash_impulse := 800.0
@export var fall_acceleration := 95.0
@export var glide_velocity_multiplier := 0.15

var has_double_jumped := false
var paused := false
var is_jumping := false
var is_gliding := false
var dash_available := true
# Starts as "forward", might behave weird depending checked spawn direction.
var last_direction := Vector3(0,0,-1)
#var velocity = Vector3.ZERO
var speed = 0

func _ready():
	player = self.owner
	last_direction = Vector3.FORWARD.rotated(Vector3.UP,
		%CameraPivot/Horizontal.global_transform.basis.get_euler().y).normalized()

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
		last_direction = direction
		
		%PlayerPivot.look_at(player.position + direction, Vector3.UP)
		
		if Input.is_action_pressed("sprint"): # Running.
			speed = run_speed
		else: # Walking.
			speed = walk_speed
			
	if Input.is_action_just_pressed('dash'):
		if dash_available:
			dash_available = !dash_available
			if direction.x == 0 and direction.z == 0:
				direction = last_direction
			speed = dash_impulse
			if dash_effect:
				dash_effect.set_emitting(true)
			dash_timer.start()
	
	if Input.is_action_just_pressed("jump"):
		if not is_jumping: 
			is_jumping = true
			player.velocity.y = jump_impulse
			last_direction = direction
		if not has_double_jumped and is_jumping and not player.is_on_floor():
			has_double_jumped = true
			is_jumping = true
			player.velocity.y = jump_impulse
			last_direction = direction
	
	if (Input.is_action_pressed("jump") && player.velocity.y < 0): # Glide
		is_gliding = true
		player.velocity.y -= fall_acceleration * glide_velocity_multiplier * delta
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		is_gliding = false
		player.velocity.y -= fall_acceleration * delta
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
		if player.is_on_floor() and player.get_slide_collision_count() > 0: # Reset both jumps.
			has_double_jumped = false
			is_jumping = false
		
	# Assign move_and_slide to velocity prevents the velocity from accumulating.
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector3.UP)
	player.move_and_slide()
	player.velocity = player.velocity


func _on_dash_timer_timeout():
	dash_available = true
