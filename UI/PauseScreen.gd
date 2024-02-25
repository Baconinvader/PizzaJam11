extends Control

class_name PauseScreen

@export var test:String

func _ready():
	for child in g.screens:
		child.queue_free()
	g.screens.append(self)
	$audio_controls/slider.value = Sound.music_vol
	screen_init()
	
func _process(delta):
	g.player.map_marker.global_position = g.player.global_position
	
	
func screen_init():
	if g.level:
		g.player.map_marker.visible = true
		g.level.get_node("world_cam").current = true
		g.player.camera.current = false

func _on_back_button_pressed():
	queue_free()
	
func _exit_tree():
	g.screens.erase(self)
	if g.level:
		g.player.map_marker.visible = false
		g.level.get_node("world_cam").current = false
	g.player.camera.current = true
	


func _on_slider_drag_ended(value_changed):
	if value_changed:
		Sound.music_vol = $audio_controls/slider.value
