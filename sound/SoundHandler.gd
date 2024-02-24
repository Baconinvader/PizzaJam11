extends Node

var playing:bool = false:set=_set_playing,get=_get_playing
var current_music:AudioStream:set=_set_current_music

@export var main_music:AudioStream = preload("res://sound/Main_Song.mp3")

signal music_changed

func _physics_process(delta):
	g.debug_text = "%s" % current_music

func _set_playing(val:bool):
	playing = val
	$music.playing = val
	
func _get_playing():
	return playing
	


func _set_current_music(val:AudioStream):
	if current_music != val:
		current_music = val
		emit_signal("music_changed")
		
	current_music = val
	if current_music:
		$music.stream = val
	else:
		$music.stream = main_music
	playing = playing
