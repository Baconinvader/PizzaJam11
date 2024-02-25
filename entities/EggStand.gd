extends "res://entities/Interactable.gd"

func _ready():
	$egg_store/anims.current_animation = "ArmatureAction"

func interact():
	var money:float = g.player.eggs*10.0
	g.player.money += money
	g.player.eggs = 0

func met_interaction_requirements()-> bool:
	if g.player.eggs:
		return true
	else:
		return false

