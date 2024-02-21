extends "res://Item.gd"

@export var food_increase:int = 4
@export var food_icon:Texture

func pickup():
	if g.player.food < g.player.max_food:
		super.pickup()
		g.player.play_peck_anim()
		g.player.food += food_increase
		
		var food_effect:Effect = preload("res://effects/Effect.tscn").instantiate()
		if food_icon:
			food_effect.texture = food_icon
		food_effect.parent = g.player
