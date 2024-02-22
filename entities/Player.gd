extends "res://entities/Entity.gd"

class_name Player

var mouse_sensitivity:float = 1.0
@export var acceleration:float = 6.2
@export var speed:float = 20.0
@export var rotate_speed:float = PI
@export var deceleration:float = 1
@export var vel_max:float = 20.0


@export var jump_power:float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var max_food:int = 10
@onready var food = 0: set=_set_food

@export var max_eggs:int = 5
@onready var eggs = 0: set=_set_eggs

var money:float = 0
var can_control:bool = true

@onready var walk_anim:Animation = $anims.get_animation("Chicken_Walk")
@onready var idle_anim:Animation = $anims.get_animation("Chicken_Idle")

@onready var camera_base:PhysicalBone3D = $Armature/Skeleton3D.get_node("Physical Bone Chicken_Belly")

var walk_blend_amount:float = 0.0
var bones_solid:bool = false:set=_set_bones_solid


func _set_bones_solid(val:bool):
	if bones_solid == val:
		return
	bones_solid = val
	for child in $Armature/Skeleton3D.get_children():
		if child.name.contains("Physical Bone"):
			child.get_child(0).disabled = not bones_solid

func _set_food(val:int):
	food = val
	if food > max_food:
		food = 0
		lay_egg()

func _set_eggs(val:int):
	eggs = val
	if eggs > max_eggs:
		eggs = eggs

func _ready():
	bones_solid = true
	bones_solid = false
	walk_anim.loop_mode = Animation.LOOP_LINEAR
	#$anims.set_blend_time("Chicken_Walk", "Chicken_Idle", 0.5)
	pass

func reset():
	$shape.disabled = false
	bones_solid = false
	reset_pos()
	velocity = Vector3.ZERO
	alive = true
	$Armature/Skeleton3D.physical_bones_stop_simulation()
	
	
func reset_pos():
	position = g.level.get_node("player_spawn").position

func _physics_process(_delta):
	if not g.in_game:
		return
		
	if transform.origin.y < g.level.killplane_y:
		reset_pos()
	
func _process(delta):
	if not g.in_game:
		return
		
	#orient camera
	#$head.transform.origin = camera_base.transform.origin 
	
	if can_control != g.enable_controls:
		can_control = g.enable_controls
		$head/camera.enabled = can_control
		
		
	var move_vec:Vector3 = Vector3.ZERO
	if can_control and alive:
		if Input.is_action_pressed("move_forward"):
			move_vec.z = 1.0
		elif Input.is_action_pressed("move_backward"):
			move_vec.z = -1.0
			
		if Input.is_action_pressed("move_left"):
			#rotate_y(rotate_speed*delta)
			move_vec.x = 1.0
		elif Input.is_action_pressed("move_right"):
			#rotate_y(-rotate_speed*delta)
			move_vec.x = -1.0
		
	var rotate_basis:Transform3D = transform
	
	#rotate to camera
	rotate_basis = $head.transform.basis
	rotate_basis.origin = Vector3.ZERO
	
	var do_accel:bool = false
	if do_accel:
		move_vec = rotate_basis * acceleration * move_vec
	else:
		move_vec  = rotate_basis * speed * move_vec
		
	var move_frac:float = move_vec.length() / vel_max
	
	
	
	var pitch:float = $head.rotation.x
	if move_vec.length() > 0:
		var angle:float
		var forward:Vector3
		var forward_vec2:Vector2 
		
		#forward:Vector3 = rotate_basis.basis.y
		#forward_vec2:Vector2 = Vector2(forward.x, forward.z)
		#angle = -forward_vec2.angle() - (PI/2)
		#if pitch > 0:
		#	angle += PI
		
		forward = move_vec.normalized()
		forward_vec2 = Vector2(forward.x, forward.z)
		angle = -forward_vec2.angle() + (PI/2)

		
		#if pitch > 0:
		#	angle += PI
		
		$Armature.rotation.y = rotate_toward($Armature.rotation.y, angle, rotate_speed*delta*move_frac)
	
	

	#change blend
	var change_amount:float = 2.0
	if walk_blend_amount < move_frac:
		walk_blend_amount += change_amount*delta
		if walk_blend_amount > move_frac:
			walk_blend_amount = move_frac
			
	elif walk_blend_amount > move_frac:
		walk_blend_amount -= change_amount*delta
		if walk_blend_amount < move_frac:
			walk_blend_amount = move_frac
	
	$anim_tree["parameters/Walk_Blend/blend_amount"] = walk_blend_amount

	
	var vert:float = velocity.y
	velocity.y = 0.0
	
	#clamp horizontal
	var hor_vel:Vector2 = Vector2(velocity.x, velocity.z)
	if ( Vector2(move_vec.x, move_vec.z).length() == 0):
		var mag:float = min(hor_vel.length(), deceleration)
		velocity += -(velocity.normalized()) * mag

	if do_accel:
		velocity += move_vec * delta
		velocity = velocity.limit_length(vel_max)
	else:
		if move_vec.length():
			velocity = move_vec
		
	velocity.y = vert
	apply_gravity(delta)
	
	move_and_slide()
	
	
func jump():
	play_jump_anim()
	velocity.y = jump_power
		
func play_peck_anim():
	$anim_tree["parameters/Peck_OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		
func play_jump_anim():
	$anim_tree["parameters/Jump_OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		
func kill():
	
	if alive:
		$shape.disabled = true
		velocity = Vector3.ZERO
		bones_solid = true
		alive = false
		$Armature/Skeleton3D.physical_bones_start_simulation()
		var death_screen = preload("res://UI/DeathScreen.tscn").instantiate()
		g.main.add_child(death_screen)
		
func lay_egg():
	eggs += 1
	
func _input(ev:InputEvent):
	if alive:
		if (ev.is_action_pressed("jump") and is_on_floor() ):
			jump()
			
	else:
		if ev.is_action_pressed("jump") or ev.is_action_pressed("back"):
			reset()
		
	if ev.is_action_pressed("kill"):
		kill()
