extends Control

class_name PauseScreen

@export var test:String

func _ready():
	g.screens.append(self)
	screen_init()
	
func _process(delta):
	$album2/album_viewport/sprite.rotation.y += 1.0*delta
	
func screen_init():
	pass

func _on_back_button_pressed():
	queue_free()
	
func _exit_tree():
	g.screens.erase(self)
	
