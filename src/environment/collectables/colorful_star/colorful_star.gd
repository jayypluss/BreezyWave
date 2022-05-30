extends Area

onready var mesh_instance : MeshInstance = $MeshInstance
onready var quad_mesh : QuadMesh = $MeshInstance.mesh

var t = 0.0
var player : KinematicBody
var collected = false

func _on_body_entered(body : KinematicBody):
	player = body
	t = 0.0
	collected = true


func _physics_process(delta):
	if collected:
		t += delta * 2
		mesh_instance.global_transform.origin = mesh_instance.global_transform.origin.linear_interpolate(player.global_transform.origin, t)
		quad_mesh.size = quad_mesh.size.linear_interpolate(Vector2.ZERO, t)

		if quad_mesh.size == Vector2.ZERO:
			collect()


func collect():
	print('collected')
	queue_free()
