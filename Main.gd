extends Node3D

class_name Main

# Called when the node enters the scene tree for the first time.
func _ready():
	g.player = preload("res://entities/Player.tscn").instantiate()
	add_child(g.player)
	
	g.level = preload("res://level/Level.tscn").instantiate()
	add_child(g.level)
	
	g.player.reset()
	
	g.main = self
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	$shop.hide_shop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$debug.text = g.debug_text
	
func _input(ev:InputEvent):
	var ev_mouse:InputEventMouseMotion = ev as InputEventMouseMotion
	if ev_mouse:
		if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			#TODO fix for web
			get_viewport().warp_mouse(Vector2(0.5, 0.5))
	
	if ev.is_action_pressed("back"):
		pass
		#if get_node("PauseScreen")
	
