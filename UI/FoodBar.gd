extends Control

var textures:Dictionary = {
	0:preload("res://materials/FoodBar/FoodBar_0%.png"),
	20:preload("res://materials/FoodBar/FoodBar_20%.png"),
	40:preload("res://materials/FoodBar/FoodBar_40%.png"),
	50:preload("res://materials/FoodBar/FoodBar_50%.png"),
	60:preload("res://materials/FoodBar/FoodBar_60%.png"),
	80:preload("res://materials/FoodBar/FoodBar_80%.png"),
	100:preload("res://materials/FoodBar/FoodBar_100%.png"),
}

func _physics_process(_delta):
	$bar.max_value = g.player.max_food
	$bar.value = g.player.food
	
	var bar_percentage:float = ( float(g.player.food)/float(g.player.max_food) ) *100.0
	$percentage.text = "%s%%" % bar_percentage
	
	var tex:Texture2D
	for num in textures:
		tex = textures[num]
		if bar_percentage >= num:
			$texture_progress.texture = tex
		else:
			break
	
	
