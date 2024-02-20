extends Control

class_name ShopItemView

@export var item:ShopItem :set=_set_item


func _set_item(val:ShopItem):
	if item:
		item.disconnect("bought_item", _on_bought_item)
	item = val
	if item:
		$icon.texture = item.icon
		$name.text = item.item_name
		$desc.text = item.item_description
		$cost.text = "$%s" % item.cost
	else:
		$icon.texture = null
		$name.text = ""
		$desc.text = ""
		$cost.text = ""
	


func _physics_process(delta):
	if item:
		if not item.bought and item.cost <= g.player.money:
			$buy_button.disabled = false
		else:
			$buy_button.disabled = true
	else:
		$buy_button.disabled = true

func _on_buy_button_pressed():
	item.buy()
	
func _on_bought_item():
	pass
	
