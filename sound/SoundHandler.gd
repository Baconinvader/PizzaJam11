extends Node

var playing:bool = false:set=_set_playing,get=_get_playing
var current_music:AudioStream:set=_set_current_music

var music_vol:float = 0.35:set=_set_music_vol
var music_min_db:float = -15
var music_max_db:float = 20


@export var main_music:AudioStream = preload("res://sound/Main_Song.mp3")

@export var sounds:Dictionary = {
	"eat":preload("res://sound/eat.wav"),
	"egg":preload("res://sound/egg.wav"),
	"footstep":preload("res://sound/footstep.wav"),
	"sell":preload("res://sound/sell.wav"),
	"buy":preload("res://sound/buy.wav")
	
}

signal music_changed

func _set_music_vol(val:float):
	music_vol = val
	
	var db:float
	if music_vol:
		db = music_min_db + ((music_max_db-music_min_db)*music_vol)
	else:
		db = -80
		
	$music.stream_paused = true
	$music.volume_db = db
	$music.stream_paused = false
	$sfx.volume_db = db

func _physics_process(delta):
	g.debug_text = "%s" % current_music

func _set_playing(val:bool):
	playing = val
	$music.playing = val
	
func _get_playing():
	return playing
	
func play_sound(name:String):
	$sfx.stream = sounds[name]
	$sfx.playing = true

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
