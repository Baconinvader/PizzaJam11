extends "res://entities/Entity.gd"

class_name Player

var mouse_sensitivity:float = 1.0

func _input(ev):
	var mouse_event = ev as InputEventMouseMotion
	if (mouse_event):
		print(mouse_event)
		
		var current_qat = Quaternion($head.global_transform.basis)
		var a =(-ev.relative.x * mouse_sensitivity)*PI/180
		var factor = sin( a / 2.0 )
		var x = 0 * factor
		var y = 1 * factor
		var z = 0 * factor
		var w = cos( a / 2.0 )
		var new_ang_hor = Quaternion(x, y, z, w).normalized()
		
		a =(ev.relative.y * mouse_sensitivity)*PI/180
		factor = sin( a / 2.0 )
		x = 1 * factor
		y = 0 * factor
		z = 0 * factor
		w = cos( a / 2.0 )
		var new_ang_ver = Quaternion(x, y, z, w).normalized()
		
		
		current_qat = current_qat * new_ang_hor * new_ang_ver
		current_qat.z = 0
		#clamp
		current_qat.x = clampf(current_qat.x, -0.1, 0.4)
		current_qat.y = clampf(current_qat.y, -0.6, 0.6)
		
		#current_qat.z = current_qat.x.cross(current_qat.y)
		$head.global_transform.basis = Basis(current_qat)
		g.debug_text = str(current_qat)#$head.global_transform.basis
