extends "res://Item.gd"

@export var food_increase:int = 4

func pickup():
	if g.player.food < g.player.max_food:
		super.pickup()
		g.player.food += food_increase
