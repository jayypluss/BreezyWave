extends SoftBody3D


func _ready():
	var pinned_points: PackedInt32Array = self.pinned_points
	pinned_points.append_array(range(321,384))
	self.pinned_points = pinned_points
