extends Node3D

@export var obj:Node3D

@export var min_range:float = 100.0
@export var max_range:float = 1000.0
@export var min_alpha:float = 0.1
@export var max_alpha = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if obj:
		if not is_instance_valid(obj):
			obj = null
		else:
			visible = true
			var diff:Vector3 = obj.global_position-global_position
			var diff_2d:Vector2 = Vector2(diff.x, diff.z)
			var angle:float = diff_2d.angle()
			rotation.y = -angle
			
			
			var dist:float = diff_2d.length()
			var clamped_dist = clampf(dist, min_range, max_range)
			var alpha_frac:float = 1.0 - (clamped_dist/(max_range-min_range))
			$sprite.modulate.a = min_alpha + (alpha_frac*(max_alpha-min_alpha))
			
	else:
		visible = false
