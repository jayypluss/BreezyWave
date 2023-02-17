extends Node

@export var walk_speed := 14.0
@export var run_speed := 22.0

@export var jump_impulse := 25.0
@export var fall_acceleration := 75.0

@export var paused := false
@export var is_jumping := false

@onready var player: Player

# Starts as "forward", might behave weird depending checked spawn direction.
var last_direction := Vector3(0,0,-1)

#var velocity = Vector3.ZERO
var speed = 0

func _ready():
	player = self.owner

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_front"):
		print('move_front pressed')
	if Input.is_action_pressed("move_back"):
		print('move_back pressed')
	if Input.is_action_pressed("move_left"):
		print('move_left pressed')
	if Input.is_action_pressed("move_right"):
		print('move_right pressed')
		
		
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
		
		%PlayerBody.look_at(player.position + direction, Vector3.DOWN)
		
		if Input.is_action_pressed("sprint"): # Running.
			speed = run_speed
#			$AnimationPlayer.speed_scale = 3.0
		else: # Walking.
			speed = walk_speed
#			$AnimationPlayer.speed_scale = 2.25
	else: # Idle
#		$AnimationPlayer.speed_scale = 1.0
		pass
	
	if not is_jumping and Input.is_action_pressed("jump"): # Single jump.
		player.velocity.y = jump_impulse
		is_jumping = true
	elif player.is_on_floor() and player.get_slide_collision_count() > 0: # Reset both jumps.
		is_jumping = false
		
	player.velocity.y -= fall_acceleration * delta

	player.velocity.x = direction.x * speed
	player.velocity.z = direction.z * speed
	
	# Assign move_and_slide to velocity prevents the velocity from accumulating.
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector3.UP)
	player.move_and_slide()
	player.velocity = player.velocity
