extends "res://Item.gd"

@export var food_increase:int = 4

func pickup():
	super.pickup()
	g.player.food += food_increase
