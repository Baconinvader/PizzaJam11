extends "res://entities/Interactable.gd"


func interact():
	g.main.get_node("shop").show_shop()

func met_interaction_requirements()-> bool:
	return true
