extends Node3D

func pickup():
	queue_free()

func _on_pickup_area_body_entered(body):
	if body is Player:
		pickup()
