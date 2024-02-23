extends Node

class_name VinylShopItems

signal item_bought

func _ready():
	for item:ShopItem in get_children():
		item.connect("bought_item", _on_bought_item)
		
func _on_bought_item():
	emit_signal("item_bought")
