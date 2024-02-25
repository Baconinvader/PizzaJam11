extends PauseScreen

func _process(delta):
	$album/album_viewport/sprite.rotation.y += 1.0*delta
