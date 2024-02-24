extends PauseScreen

func screen_init():
	Sound.current_music = preload("res://sound/Death_Song.mp3")
	Sound.playing = true

func _exit_tree():
	g.screens.erase(self)
	Sound.current_music = null
	Sound.playing = true
	g.player.reset()
	
func _input(ev:InputEvent):
	if ev.is_action_pressed("jump"):
		queue_free()
	
