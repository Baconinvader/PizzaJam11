extends Node3D

@export var vehicles:Array[Vehicle]
@export var vehicle_scene:PackedScene
@export var max_vehicles:int = 1
@export var spawn_time:float = 1.0
@export var spawn_variance = 3.0

@export var vehicle_path:String = "path1"

@export var materials:Array[StandardMaterial3D]

func set_wait_time():
	var variance:float = randf_range(-spawn_variance, spawn_variance)
	var time:float = max(spawn_time+spawn_variance, 2.0)
	$spawn.wait_time = spawn_time

func _ready():
	set_wait_time()

func reset():
	for vehicle in vehicles:
		if is_instance_valid(vehicle):
			vehicle.queue_free()

func spawn():
	var new_vehicle:Vehicle = vehicle_scene.instantiate()
	new_vehicle.connect("tree_exited", _on_vehicle_tree_exited)
	new_vehicle.position = position
	print("POS:",position)
	new_vehicle.path_name = vehicle_path
	
	#set material
	var mat:StandardMaterial3D = materials.pick_random()
	
	g.level.get_node("vehicles").add_child(new_vehicle)
	vehicles.append(new_vehicle)
	
	new_vehicle.mesh.set_surface_override_material(0,mat)

func _on_spawn_timeout():
	set_wait_time()
	var can_spawn:bool = true
	if vehicles.size() >= max_vehicles:
		can_spawn = false
	else:
		for check_body in $spawn_check_area.get_overlapping_bodies():
			if check_body is Vehicle or check_body is Player:
				can_spawn = false
	if can_spawn:
		spawn()
		
func _on_vehicle_tree_exited():
	for vehicle:Vehicle in vehicles:
		if is_instance_valid(vehicle):
			vehicles.erase(vehicle)
			break



