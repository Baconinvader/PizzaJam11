extends "res://entities/Interactable.gd"

func _ready():
	connect("can_interact_changed", _on_can_interact_changed)

func interact():
	var money:float = g.player.eggs*10.0
	g.player.money += money
	g.player.eggs = 0

func met_interaction_requirements()-> bool:
	if g.player.eggs:
		return true
	else:
		return false
		
func _on_can_interact_changed(val:bool):
	if val:
		g.main.get_node("sell_prompt").visible = true
	else:
		g.main.get_node("sell_prompt").visible = false
