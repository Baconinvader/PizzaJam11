extends Control

class_name PauseScreen

@export var test:String

func _ready():
	g.screens.append(self)
	screen_init()
	
func screen_init():
	pass

func _on_back_button_pressed():
	queue_free()
	
func _exit_tree():
	g.screens.erase(self)
	
