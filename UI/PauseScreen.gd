extends Control

class_name PauseScreen

func _ready():
	g.screens.append(self)

func _on_back_button_pressed():
	queue_free()
	
func _exit_tree():
	g.screens.erase(self)
	
