extends Spatial

func _ready():
	if !OS.is_debug_build():
		print('Opening level_1 in debug mode.')
		$Player.transform.origin = Vector3.ZERO



func _on_Area_body_entered(body):
	print('body entered: ', body)
