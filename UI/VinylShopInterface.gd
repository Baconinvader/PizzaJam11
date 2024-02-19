extends Control

func show_shop():
	visible = true
	g.enable_controls = false
	
func hide_shop():
	visible = false
	g.enable_controls = true

func _on_close_pressed():
	hide_shop()
	
func _input(ev:InputEvent):
	if visible and ev.is_action_pressed("back"):
		hide_shop()
