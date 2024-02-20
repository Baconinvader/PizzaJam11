extends Node

var debug_text:String = ""

var player: Player
var level: Level

var main:Main

var enable_controls:bool:set=_set_enable_controls

var screens:Array = []

func _set_enable_controls(val:bool):
	enable_controls = val
	if enable_controls:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
