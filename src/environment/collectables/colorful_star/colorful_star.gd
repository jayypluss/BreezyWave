extends Area

onready var mesh_instance : MeshInstance = $MeshInstance
onready var quad_mesh : QuadMesh = $MeshInstance.mesh
#onready var animation_player : AnimationPlayer = $AnimationPlayer

#quad_mesh.

var t = 0.0
var player : KinematicBody
var collected = false

func _on_body_entered(body : KinematicBody):
	if body.name == "Player":
		player = body
		print('collect')
		t = 0.0
		collected = true
#		animation_player.play("go_to_player")
		
		
		
func _physics_process(delta):
	if collected:
		t += delta * 2
		print(player.global_transform.origin)
		mesh_instance.global_transform.origin = mesh_instance.global_transform.origin.linear_interpolate(player.global_transform.origin, t)
		quad_mesh.size = quad_mesh.size.linear_interpolate(Vector2.ZERO, t)
		
		if quad_mesh.size == Vector2.ZERO:
			queue_free()


func set_collected():
	queue_free()
