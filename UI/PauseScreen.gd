extends Control

class_name PauseScreen

func _ready():
	g.enable_controls = false

func _on_back_button_pressed():
	exit_screen()
	
	
func exit_screen():
	g.enable_controls = true
	queue_free()
	
