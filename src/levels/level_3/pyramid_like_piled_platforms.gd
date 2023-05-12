extends Node3D

@onready var first_floor_mesh = $Combiner/FirstFloorMesh
@onready var second_floor_mesh = $Combiner/SecondFloorMesh
@onready var third_floor_mesh = $Combiner/ThirdFloorMesh

var tweening_meshes: Array[CSGMesh3D] = []

func _on_first_floor_enter_body_entered(_body):
	change_mesh_color(first_floor_mesh)

func _on_second_floor_enter_2_body_entered(_body):
	change_mesh_color(second_floor_mesh)

func _on_third_floor_enter_3_body_entered(_body):
	change_mesh_color(third_floor_mesh)


func change_mesh_color(mesh: CSGMesh3D):
	if (!tweening_meshes.has(mesh) and mesh and mesh.material):
		tweening_meshes.append(mesh)
		var material_initial_color = mesh.material.albedo_color
		var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(mesh.material, "albedo_color", Color('ce00cc'), 0.5)
		tween.tween_property(mesh.material, "albedo_color", Color('87cace'), 0.5)
		tween.tween_property(mesh.material, "albedo_color", Color('58e17a'), 0.5)
		tween.tween_property(mesh.material, "albedo_color", material_initial_color, 0.5)
		tween.tween_callback(
			func(): 
				tweening_meshes.remove_at(tweening_meshes.find(mesh))
		)
