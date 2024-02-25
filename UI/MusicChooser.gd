extends Control

@export var items:VinylShopItems

var music_index:int = 0
var music:MusicChoice:get=_get_music

func _get_music():
	if music_index < $items.get_child_count():
		var choice:MusicChoice = $items.get_child(music_index)
		return choice
	else:
		return null

func _ready():
	items.connect("item_bought", _on_item_bought)
	Sound.connect("music_changed", _on_music_changed)
	update_music()
	update_shown()
	
	var last_key:String = InputMap.action_get_events("mus_last")[0].as_text()[0]
	var next_key:String = InputMap.action_get_events("mus_next")[0].as_text()[0]
	var toggle_key:String = InputMap.action_get_events("mus_toggle")[0].as_text()[0]
	
	$play_controls/label.text = toggle_key
	$play_controls/last/label.text = last_key
	$play_controls/next/label.text = next_key
	
func _on_music_changed():
	if Sound.current_music != music:
		update_shown()

func _physics_process(delta):
	pass
	#g.debug_text = "%s (%s)" % [music,music_index]
	
func update_shown():
	if not $items.get_child_count():
		visible = false
	else:
		visible = true
	
	var i:int = 0
	var showing_last:bool = false
	var showing_next:bool = false
	for child:MusicChoice in $items.get_children():
		child.visible = false
		if i == music_index:
			child.position = $current.position
			child.visible = true
		
		elif i == int(fposmod((music_index+1), $items.get_child_count())):
			child.position = $next.position
			showing_next = true
		
		elif i == int(fposmod((music_index-1), $items.get_child_count())):
			child.position = $last.position
			showing_last = true
			
			
		if child.visible:
			child.position.x -= child.size.x/2
			child.position.y -= child.size.y/2
			
		i += 1
		
	$play_controls/last.disabled = not showing_last
	$play_controls/next.disabled = not showing_next
	
	if music:
		if Sound.playing and Sound.current_music != Sound.main_music and Sound.current_music != null:
			$play_controls/play.disabled = true
			$play_controls/pause.disabled = false
		else:
			$play_controls/play.disabled = false
			$play_controls/pause.disabled = true
	else:
		$play_controls/play.disabled = true
		$play_controls/pause.disabled = true
		
func update_music():
	if music and music.item:
		$music_text.text = music.item.item_name
		var mus_stream:AudioStream = music.item.stream
		Sound.current_music = mus_stream
		
func _on_item_bought():
	#find new item
	var new_item:ShopItem
	for item:ShopItem in items.get_children():
		if item.bought:
			var item_found:bool = false
			for choice:MusicChoice in $items.get_children():
				if choice.item == item:
					item_found = true
					break
			if not item_found:
				new_item = item
				break
	
	var new_choice:MusicChoice = preload("res://UI/MusicChoice.tscn").instantiate()
	new_choice.item = new_item
	$items.add_child(new_choice)
	new_choice.visible = false
	update_shown()

func _input(ev:InputEvent):
	if ev.is_action_pressed("mus_last"):
		last_track()
		
	if ev.is_action_pressed("mus_next"):
		next_track()

	if ev.is_action_pressed("mus_toggle"):
		toggle_playing()

func last_track():
	if g.player.alive:
		music_index = int(fposmod((music_index-1), $items.get_child_count()))
		update_music()
		Sound.playing = true
		update_shown()

func next_track():
	if g.player.alive:
		music_index = int(fposmod((music_index+1), $items.get_child_count()))
		update_music()
		Sound.playing = true
		update_shown()

func toggle_playing():
	
		if music:
			if not $play_controls/play.disabled:
				_on_play_pressed()
			elif not $play_controls/pause.disabled:
				_on_pause_pressed()
		
func _on_play_pressed():
	if g.player.alive:
		update_music()
		Sound.playing = true
		update_shown()
	
	
func _on_pause_pressed():
	if g.player.alive:
		update_music()
		Sound.current_music = null
		#Sound.playing = false
		update_shown()


func _on_last_pressed():
	last_track()

func _on_next_pressed():
	next_track()
