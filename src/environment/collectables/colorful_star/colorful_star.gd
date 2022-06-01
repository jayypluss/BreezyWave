extends Area

onready var mesh_instance : MeshInstance = $MeshInstance
onready var quad_mesh : QuadMesh = $MeshInstance.mesh
onready var sparkle_sound_effect : AudioStreamPlayer = $SparkleSoundEffect
onready var delete_after_collect_timer : Timer = $DeleteAfterCollectTimer

onready var key = self.get_parent().get_parent().name+"-"+name

var t = 0.0
var player : KinematicBody
var collected = false

func _ready():
	if GameState.colorful_stars_collected.has(key):
		queue_free()

func _on_body_entered(body: KinematicBody):
	player = body
	t = 0.0
	collected = true


func _physics_process(delta):
	if collected:
		t += delta * 2
		if is_instance_valid(mesh_instance) && is_instance_valid(player):
			mesh_instance.global_transform.origin = mesh_instance.global_transform.origin.linear_interpolate(player.global_transform.origin, t)
		quad_mesh.size = quad_mesh.size.linear_interpolate(Vector2.ZERO, t)

		if quad_mesh.size == Vector2.ZERO:
			collect()


func collect():
	sparkle_sound_effect.play()
	collected = false
	GameState.colorful_stars_collected[key] = true
	get_tree().call_group("update_on_star_collect", "on_star_collected")
	delete_after_collect_timer.start()


func _on_Timer_timeout():
	queue_free()
