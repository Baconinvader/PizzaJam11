extends "res://entities/Entity.gd"

class_name Player

var mouse_sensitivity:float = 1.0
@export var acceleration:float = 6.2
@export var speed:float = 20.0
@export var deceleration:float = 1
@export var vel_max:float = 20.0

@export var gravity:float = 9.8*2
@export var jump_power:float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var max_food:int = 10
@onready var food = 0: set=_set_food

@export var max_eggs:int = 5
@onready var eggs = 0: set=_set_eggs

var money:float = 0
var can_control:bool = true

@onready var walk_anim:Animation = $anims.get_animation("Chicken_Walk")
@onready var idle_anim:Animation = $anims.get_animation("Chicken_Idle")

var walk_blend_amount:float = 0.0

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
	walk_anim.loop_mode = Animation.LOOP_LINEAR
	#$anims.set_blend_time("Chicken_Walk", "Chicken_Idle", 0.5)
	pass

func reset():
	reset_pos()
	
func reset_pos():
	position = g.level.get_node("player_spawn").position

func _physics_process(_delta):
	if transform.origin.y < -10:
		reset_pos()
	
func _process(delta):
	if can_control != g.enable_controls:
		can_control = g.enable_controls
		$head/camera.enabled = can_control
		
	var move_vec:Vector3 = Vector3.ZERO
	if can_control:
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
		
	var move_frac:float = move_vec.length() / vel_max
	
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
		
	if is_on_floor():
		pass
	else:
		vert -= gravity*delta
	velocity.y = vert
	move_and_slide()
	
	
func jump():
	play_jump_anim()
	velocity.y = jump_power
		
func play_peck_anim():
	$anim_tree["parameters/Peck_OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		
func play_jump_anim():
	$anim_tree["parameters/Jump_OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		
		
func lay_egg():
	eggs += 1
	
func _input(ev:InputEvent):
	if (ev.is_action_pressed("jump") and is_on_floor() and can_control ):
		jump()
		
	if ev.is_action_pressed("kill"):
		pass
