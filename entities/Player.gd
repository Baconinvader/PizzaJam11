extends "res://entities/Entity.gd"

class_name Player

var mouse_sensitivity:float = 1.0
@export var acceleration:float = 0.1
@export var vel_keep:float = 0.98
@export var vel_max:float = 5.0

@export var gravity:float = 0.98
@export var jump_power:float = 5.0

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
	move_vec = rotate_basis * move_vec
	
	var vert:float = velocity.y
	velocity.y = 0.0
	
	#clamp horizontal
	velocity += move_vec * delta
	velocity *= vel_keep
	velocity = velocity.limit_length(vel_max)
	
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
	if (ev.is_action_pressed("jump")):
		jump()
	
