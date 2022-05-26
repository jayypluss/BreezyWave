extends SoftBody


func _ready():
	var pinned_points: PoolIntArray = self.pinned_points
	print(pinned_points)
	pinned_points.append_array(range(321,382))
	print(pinned_points)
	self.pinned_points = pinned_points
