extends Control

class_name MusicChoice

var item:ShopItem:set=_set_item

func _set_item(val:ShopItem):
	item = val
	if item:
		$icon.texture = item.icon
		$name.text = item.item_name
	else:
		$icon.visible = false
		$name.visible = false
