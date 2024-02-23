extends Node

var current_music:AudioStream:set=_set_current_music

func _set_current_music(val:AudioStream):
	$music.stream = val
	if not current_music:
		val.play()
	
	current_music = val
