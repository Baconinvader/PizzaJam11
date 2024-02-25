extends Node3D

var player_in_water:bool = false


func _on_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area == g.player.water_area:
		player_in_water = true
		g.player.in_water = true
		g.main.get_node("water").visible = true
		if not g.player.invincibile:
			g.player.kill()


func _on_area_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area == g.player.water_area:
		player_in_water = false
		g.player.in_water = false
		g.main.get_node("water").visible = false

