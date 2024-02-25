extends Node

class_name VinylShopItems

signal item_bought
signal all_items_bought

func _ready():
	for item:ShopItem in get_children():
		item.connect("bought_item", _on_bought_item)
		
func _on_bought_item():
	emit_signal("item_bought")
	var bought_all:bool = true
	for child in get_children():
		if not child.bought:
			bought_all = false
			break
	if bought_all:
		emit_signal("all_items_bought")
			
