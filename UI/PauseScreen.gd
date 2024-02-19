extends Control

func _ready():
	g.enable_controls = false

func _on_back_button_pressed():
	g.enable_controls = true
	queue_free()
	
