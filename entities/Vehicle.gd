extends "res://entities/Obstacle.gd"

@export var path_name:String = "path1"
var path:Path3D
var curve:Curve3D

var speed:float = 10.0
var curve_progress:float
var sample_head:float = 0.0

var target:Vector3 = Vector3.ZERO

func _ready():
	pass
	
func _process(delta):
	if g.main and not curve:
		path = g.level.get_node("paths/" + path_name)
		curve = path.curve
		curve_progress = fmod(curve_progress,curve.point_count)
		target = curve.samplef( fmod(curve_progress + sample_head,curve.point_count) )
		
		
	var dist:float = (position-target).length()
	var max_dist:float = 1.0
	if dist < max_dist:
		curve_progress += 0.002
		curve_progress = fmod(curve_progress,curve.point_count)
		target = curve.samplef( fmod(curve_progress + sample_head,curve.point_count) )


	dist = (position-target).length()
	var vel:float = speed#minf(speed, dist)
	var diff:Vector3 = target-position
	velocity = diff.normalized()*vel
	
	
	var angle = -Vector2(velocity.x, velocity.z).angle() + (PI*0.5)
	var rotate_speed = 0.5
	rotation.y = rotate_toward(rotation.y, angle, rotate_speed*delta)
	#print(position," -> ",target," ",velocity," ",angle)
	#position = target
	
	#print(angle)
	#rotation.y = angle
	
	move_and_slide()
