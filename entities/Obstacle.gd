extends Entity


func _physics_process(_delta):
	var colliding:KinematicCollision3D = get_last_slide_collision()
	if colliding:
		if colliding.get_collider() is Player:
			g.player.kill()
