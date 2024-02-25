extends Control

class_name VinylShopInterface

var items:VinylShopItems: set=_set_items

func _set_items(val:VinylShopItems):
	items = val
	var box:VBoxContainer = $background_panel/scroll/vbox
	#remove old
	var children = box.get_children()
	for child in children:
		child.queue_free()
		
	if not items:
		return
		
	#addnew
	for item in items.get_children():
		var new_view:ShopItemView = preload("res://UI/ShopItemView.tscn").instantiate()
		new_view.item = item
		box.add_child(new_view)

func _ready():
	g.screens.append(self)
	items.connect("all_items_bought", _on_all_items_bought)

func _on_all_items_bought():
	g.main.add_child(preload("res://UI/WinScreen.tscn").instantiate())
	

func _input(ev:InputEvent):
	pass
		
func _exit_tree():
	g.screens.erase(self)


func _on_close_pressed():
	queue_free()
