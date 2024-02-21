extends CharacterBody3D

class_name Entity

@export var gravity:float = 9.8*2
var alive:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_gravity(delta:float):
	if is_on_floor():
		pass
	else:
		if alive:
			velocity.y -= gravity*delta
