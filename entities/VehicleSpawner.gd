extends Node3D

@export var vehicles:Array[Vehicle]
@export var vehicle_scene:PackedScene
@export var max_vehicles:int = 1
@export var spawn_time:float = 1.0

@export var vehicle_path:String = "path1"

@export var materials:Array[StandardMaterial3D]

func _ready():
	$spawn.wait_time = spawn_time

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
	if vehicles.size() < max_vehicles:
		spawn()
		
func _on_vehicle_tree_exited():
	for vehicle:Vehicle in vehicles:
		if is_instance_valid(vehicle):
			vehicles.erase(vehicle)
			break

