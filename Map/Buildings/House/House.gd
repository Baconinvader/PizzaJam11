extends StaticBody3D

@export var materials:Array[Material] = [
	preload("res://Map/Buildings/House/House_Cyan.tres"),
	preload("res://Map/Buildings/House/House_Green.tres"),
	preload("res://Map/Buildings/House/House_Grey.tres"),
	preload("res://Map/Buildings/House/House_Pink.tres"),
	preload("res://Map/Buildings/House/House_Purple.tres"),
	preload("res://Map/Buildings/House/House_Yellow.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var tex_choice:Material = materials.pick_random()
	$model.set_surface_override_material(0,tex_choice)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
