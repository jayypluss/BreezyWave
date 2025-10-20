extends Node
class_name PlayerInput

signal toggle_camera(options)

@onready var player: Player
@onready var dash_effect: GPUParticles3D = $"../PlayerPivot/Effects/DashEffect"
@onready var jump_effect: GPUParticles3D = $"../PlayerPivot/Effects/JumpEffect"
@onready var dash_timer = $"../PlayerPivot/Effects/DashTimer"

@export var walk_speed := 14.0
@export var run_speed := 50.0
@export var jump_impulse := 30.0
@export var dash_impulse := 800.0
@export var fall_acceleration := 95.0
@export var glide_velocity_multiplier := 0.15

var first_person := false
var is_double_jump_available := false
var paused := false
var available_jumps := 1
var is_gliding := false
var dash_available := true
# Starts as "forward", might behave weird depending checked spawn direction.
var last_direction := Vector3(0,0,-1)
#var velocity = Vector3.ZERO
var speed = 0

# Power-ups
var has_dash: bool = false
var has_glide: bool = false
var num_of_jumps: int = 1

var lock_movement := false

var jump_multiplier := 1.0

func force_jump(multiplier: float = 1.0):
  jump_multiplier = multiplier

func _ready():
  if %FirstPersonCamera.current:
    first_person = true
  player = self.owner
  available_jumps = num_of_jumps
  last_direction = Vector3.FORWARD.rotated(Vector3.UP,
    %CameraPivot/Horizontal.global_transform.basis.get_euler().y).normalized()

func _on_toggle_camera(options):
  var anim_duration:= 0.1
  if options and options.anim_duration:
    anim_duration = options.anim_duration
  var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
  if %Camera3D.current:
    # Will become FIRST person
    tween.tween_property(%Camera3D, "position", %FirstPersonCamera.position, anim_duration)
    tween.tween_callback(
      func(): 
        %FirstPersonCamera.set_initial_position()			
        first_person = true
        %FirstPersonCamera.make_current()
        GameState.player.set_meshes_visibility(false)
        print(options)
        if options and options.after_anim_action:
          options.after_anim_action.call()
    )
  else:
    # Will become THIRD person
    tween.tween_property(%FirstPersonCamera, "position", %Camera3D.position, anim_duration)
    tween.tween_callback(
      func(): 
        %CameraPivot.set_initial_position()
        first_person = false
        %Camera3D.make_current()
        GameState.player.set_meshes_visibility(true)
        print(options)
        if options and options.after_anim_action:
          options.after_anim_action.call()
    )

func _physics_process(delta: float) -> void:
  if paused: # Used to prevent movement during a cutscene.
    return
  
  # Get direction vector based checked input.
  var direction = Vector3(
    Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
    0,
    Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
  )
  
  if lock_movement:
    direction = Vector3.ZERO
  
#	# Rotate direction based checked camera.
  var horizontal_rotation
  
  if first_person:
    horizontal_rotation = %FirstPersonCamera.global_transform.basis.get_euler().y
    direction = direction.rotated(Vector3.UP, horizontal_rotation).normalized()
  else:
    horizontal_rotation = %CameraPivot/Horizontal.global_transform.basis.get_euler().y
    direction = direction.rotated(Vector3.UP, horizontal_rotation).normalized()
  
  if direction != Vector3.ZERO: # Player is moving.
    direction = direction.normalized()
    last_direction = direction
    
    if !first_person:
      %PlayerPivot.look_at(player.position + direction, Vector3.UP)
#		else:
#			var camera_direction = %FirstPersonCamera.project_ray_normal(get_viewport().get_visible_rect().size / 2)
#			print(camera_direction)
#			direction = camera_direction
#			direction = Vector3(
#				Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
#				0,
#				Input.get_action_strength("move_back") - Input.get_action_strength("move_front")
#			)
#			%PlayerPivot.look_at(camera_direction, Vector3.UP)
    
    if Input.is_action_pressed("sprint"): # Running.
      speed = run_speed
    else: # Walking.
      speed = walk_speed
    
  
  if Input.is_action_just_pressed('toggle_camera'):
    _on_toggle_camera(null)
    
  if has_dash:	
    if Input.is_action_just_pressed('dash'):
      if dash_available:
        dash_available = !dash_available
        if direction.x == 0 and direction.z == 0:
          direction = last_direction
        speed = dash_impulse
        if dash_effect:
          dash_effect.set_emitting(true)
        dash_timer.start()
  
  if Input.is_action_pressed("jump") or jump_multiplier > 1.0:
    if num_of_jumps == 1 and !player.is_on_floor() and player.get_slide_collision_count() == 0:
      available_jumps = 0
      jump_multiplier = 1.0
      
    if available_jumps > 0:
      available_jumps -= 1
      player.velocity.y = jump_impulse*jump_multiplier
      if jump_effect:
        jump_effect.set_emitting(true)
      last_direction = direction
  
  if has_glide:
    if (Input.is_action_pressed("jump") && player.velocity.y < 0): # Glid
      print('glide')
      is_gliding = true
      player.velocity.y -= fall_acceleration * glide_velocity_multiplier * delta
      player.velocity.x = direction.x * speed
      player.velocity.z = direction.z * speed
    else:
      is_gliding = false
      player.velocity.y -= fall_acceleration * delta
      player.velocity.x = direction.x * speed
      player.velocity.z = direction.z * speed
  else:
    player.velocity.y -= fall_acceleration * delta
    player.velocity.x = direction.x * speed
    player.velocity.z = direction.z * speed
    
  # Assign move_and_slide to velocity prevents the velocity from accumulating.
  player.set_velocity(player.velocity)
  player.set_up_direction(Vector3.UP)
  player.move_and_slide()
  player.velocity = player.velocity

  if player.is_on_floor() and player.get_slide_collision_count() > 0: # Reset jumps.
    available_jumps = num_of_jumps

func _on_dash_timer_timeout():
  dash_available = true


func _on_tp_camera_enter_player(_body):
  if _body is Player:
    player.hide_eyes()
    
