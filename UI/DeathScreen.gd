extends PauseScreen

func _ready():
	print(super())
	super()._ready()
	Sound.current_music = preload("res://sound/Death_Song.mp3")

func _exit_tree():
	g.screens.erase(self)
	g.player.reset()
	
func _input(ev:InputEvent):
	if ev.is_action_pressed("jump"):
		queue_free()
	
