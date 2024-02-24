extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	g.enable_controls = false
	g.screens.append(self)
	Sound.current_music = preload("res://sound/Main_Song.mp3")
	Sound.playing = true


func _on_start_button_pressed():
	g.level = preload("res://level/Level.tscn").instantiate()
	g.main.add_child(g.level)
	
	g.player.reset()
	g.in_game = true
	g.enable_controls = true
	
	queue_free()


func _exit_tree():
	g.screens.erase(self)
