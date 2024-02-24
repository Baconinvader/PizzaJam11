extends Node

var current_music:AudioStream:set=_set_current_music

func _set_current_music(val:AudioStream):
	$music.stream = val
	$music.playing = true
	
	current_music = val
