extends Node3D

class_name Level

@export var killplane_y:float = -40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func reset():
	for spawner in get_tree().get_nodes_in_group("spawners"):
		spawner.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
