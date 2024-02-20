extends "res://entities/Interactable.gd"


func interact():
	var interface:VinylShopInterface = preload("res://UI/VinylShopInterface.tscn").instantiate()
	var items = g.main.get_node("shop_items")
	interface.items = items
	interface.global_position = Vector2(200,200)
	g.main.add_child(interface)

func met_interaction_requirements()-> bool:
	return true
