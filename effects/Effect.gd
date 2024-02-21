extends Node3D

class_name Effect

@export var lifetime:int = 3
@export var velocity:Vector3 = Vector3(0.0,1.5,0.0)
@export var texture:Texture2D

@export var parent:Node3D:set=_set_parent

@onready var particle_color = $particles.draw_pass_1.material.albedo_color

func _set_parent(val:Node3D):
	parent = val
	parent.add_child(self)
	position.y = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.wait_time = lifetime
	$timer.start()
	if texture:
		$sprite.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lifetime_frac:float = $timer.time_left/$timer.wait_time
	
	var fade_start = 0.2
	var fade_frac: float
	if lifetime_frac <= fade_start:
		fade_frac = lifetime_frac/(1.0-fade_start)
	else:
		fade_frac = 1.0
	
	particle_color.r = 1.0-fade_frac
	particle_color.a = fade_frac
	
	$sprite.modulate.a = fade_frac
	
	position += velocity*delta

func _on_timer_timeout():
	queue_free()
