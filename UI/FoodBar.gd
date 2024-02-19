extends Control


func _physics_process(_delta):
	$bar.max_value = g.player.max_food
	$bar.value = g.player.food
	print($bar.value,"/",$bar.max_value)
