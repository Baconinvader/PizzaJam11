extends Entity

signal can_interact_changed(val:bool)

var player_in_range:bool = false
var can_interact:bool = false: set=_set_can_interact

func _set_can_interact(val:bool):
	var old_val:bool = can_interact
	can_interact = val
	if (can_interact != old_val):
		emit_signal("can_interact_changed",can_interact)
	
func interact():
	pass
	
func met_interaction_requirements()-> bool:
	return true
	
func _physics_process(_delta):
	if player_in_range and met_interaction_requirements():
		can_interact = true
	else:
		can_interact = false
	
func _on_interact_area_body_entered(body):
	if body is Player:
		player_in_range = true

func _on_interact_area_body_exited(body):
	if body is Player:
		player_in_range = false

func _input(ev:InputEvent):
	if can_interact and ev.is_action_pressed("interact"):
		interact()
