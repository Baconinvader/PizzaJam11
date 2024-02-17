extends "res://entities/Entity.gd"

class_name Player

var mouse_sensitivity:float = 1.0
@export var acceleration:float = 6.2
@export var speed:float = 20.0
@export var deceleration:float = 1
@export var vel_max:float = 20.0

@export var gravity:float = 9.8*2
@export var jump_power:float = 15.0

func _process(delta):
	var move_vec:Vector3 = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		move_vec.z = 1.0
	elif Input.is_action_pressed("move_backward"):
		move_vec.z = -1.0
		
	if Input.is_action_pressed("move_left"):
		move_vec.x = 1.0
	elif Input.is_action_pressed("move_right"):
		move_vec.x = -1.0
		
	var rotate_basis:Transform3D = transform
	rotate_basis.origin = Vector3.ZERO
	
	var do_accel:bool = false
	if do_accel:
		move_vec = rotate_basis * acceleration * move_vec
	else:
		move_vec  = rotate_basis * speed * move_vec 
	
	var vert:float = velocity.y
	velocity.y = 0.0
	
	#clamp horizontal
	var hor_vel:Vector2 = Vector2(velocity.x, velocity.z)
	if ( Vector2(move_vec.x, move_vec.z).length() == 0):
		var mag:float = min(hor_vel.length(), deceleration)
		velocity += -(velocity.normalized()) * mag
		print("- %s (%s, %s) %s" % [(-(velocity.normalized()) * mag), mag, deceleration, hor_vel])
		
	if do_accel:
		velocity += move_vec * delta
		velocity = velocity.limit_length(vel_max)
	else:
		if move_vec.length():
			velocity = move_vec
		
	if is_on_floor():
		pass
	else:
		vert -= gravity*delta
	velocity.y = vert
	move_and_slide()
	
	g.debug_text = str(velocity)
	
func jump():
	velocity.y = jump_power
		
func _input(ev:InputEvent):
	if (ev.is_action_pressed("jump") and is_on_floor() ):
		jump()
	
