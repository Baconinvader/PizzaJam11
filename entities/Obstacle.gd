extends Entity

@export var kill_force_multiplier:float = 3.0

func _physics_process(_delta):
	var colliding:KinematicCollision3D = get_last_slide_collision()
	if colliding:
			
		if colliding.get_collider() is Player:
			g.player.kill()
			g.player.master_bone.apply_central_impulse(velocity*kill_force_multiplier)
		
