extends Node3D

@export var food_scene:PackedScene
@export var spawn_time:float = 5.0

var can_spawn:bool = true
var food:Food

# Called when the node enters the scene tree for the first time.
func _ready():
	$spawn_timer.wait_time = spawn_time
	$spawn_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	food = food_scene.instantiate()
	food.position = position
	g.level.get_node("food").add_child(food)
	food.connect("tree_exited", _on_food_exited)

func _on_spawn_blocker_screen_entered():
	can_spawn = false
func _on_spawn_blocker_screen_exited():
	can_spawn = true


func _on_spawn_timer_timeout():
	if can_spawn and not food:
		spawn()
	$spawn_timer.start()

func _on_food_exited():
	food = null
