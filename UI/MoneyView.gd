extends Control


func _physics_process(_delta):
	$text.text = "Money: $%s" % g.player.money
