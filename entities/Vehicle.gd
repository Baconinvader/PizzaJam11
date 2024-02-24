extends "res://entities/Obstacle.gd"

class_name Vehicle

@export var path_name:String = "path1"
var path:Path3D
var curve:Curve3D

var speed:float = 20.0
var curve_progress:float
var sample_head:float = 0.0

var target:Vector3 = Vector3.ZERO
var curve_offset:float = 0

var do_move:bool = true

@onready var mesh:MeshInstance3D = $Range_Rover_Rig/Skeleton3D/Range_Rover

func _ready():
	print(position)
	$sound/loop.playing = true
	
func _process(delta):
	if g.main and not curve:
		path = g.level.get_node("paths/" + path_name)
		curve = path.curve
		#curve_progress = fmod(curve_progress,curve.point_count)
		#target = curve.samplef( fmod(curve_progress + sample_head,curve.point_count) )
		
	if do_move:
		var front_length:float = 1.0
		var front_point:Vector3 = position + (velocity.normalized()*front_length)

		var old_curve_offset:float = curve_offset
		curve_offset = curve.get_closest_offset(front_point)#position
		
		if old_curve_offset == 0:
			if curve_offset < 50:
				pass
			else:
				curve_offset = 0
		else:
			if curve_offset <= old_curve_offset:
				curve_offset = old_curve_offset + 0.1

		if curve_offset >= curve.get_baked_length():
			curve_offset = 0
			#queue_free()

		target = curve.sample_baked(curve_offset, true) #curve.get_closest_point(front_point)
		target.y = position.y
		
		var dist = (position-target).length()
		var vel:float = speed#minf(speed, dist)
		var diff:Vector3 = target-position
		velocity = diff.normalized()*vel
	else:
		velocity = Vector3.ZERO
	
	
	var angle = -Vector2(velocity.x, velocity.z).angle() + (PI*0.5)
	var rotate_speed = 2.5
	rotation.y = rotate_toward(rotation.y, angle, rotate_speed*delta)
	#print(position," -> ",target," ",velocity," ",angle)
	#position = target
	
	#print(angle)
	#rotation.y = angle
	
	apply_gravity(delta)
	
	move_and_slide()


func _on_despawn_check_timer_timeout():
	var dist:float = position.distance_to(g.player.position)
	if dist <= 50:
		return
	
	var space:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query:PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(global_position, g.player.camera.global_position)
	var collision = space.intersect_ray(query)
	if collision:
		queue_free()


func _on_avoidance_check_timer_timeout():
	do_move = true
	for obj in $avoidance_area.get_overlapping_bodies():
		if obj is Vehicle:
			do_move = false
			break
			


func _on_despawn_preventor_screen_entered():
	$despawn_check_timer.stop()
func _on_despawn_preventor_screen_exited():
	$despawn_check_timer.start()
