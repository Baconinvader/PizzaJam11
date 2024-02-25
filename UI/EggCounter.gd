extends Control

var egg_scene:PackedScene = preload("res://UI/EggIcon.tscn")
var icon_count:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$label.text = "Eggs x%s/%s" % [g.player.eggs, g.player.max_eggs]
	
	var egg_count = g.player.eggs
	while (egg_count > icon_count):
		$eggs.add_child(egg_scene.instantiate())
		icon_count += 1

	while (egg_count < icon_count):
		$eggs.get_child(icon_count-1).queue_free()
		icon_count -= 1

		
