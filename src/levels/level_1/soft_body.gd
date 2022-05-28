extends SoftBody


func _ready():
	var pinned_points: PoolIntArray = self.pinned_points
	pinned_points.append_array(range(321,384))
	self.pinned_points = pinned_points
	print(pinned_points)
