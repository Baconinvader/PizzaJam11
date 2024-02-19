extends Control

func show_shop():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	g.enable_controls = false
	
func hide_shop():
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	g.enable_controls = true

func _on_close_pressed():
	hide_shop()
	
func _input(ev:InputEvent):
	if visible and ev.is_action_pressed("back"):
		hide_shop()
