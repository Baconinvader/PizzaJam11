extends Control


func _physics_process(_delta):
	print(g.player.money)
	$text.text = "Money: $%s" % g.player.money
