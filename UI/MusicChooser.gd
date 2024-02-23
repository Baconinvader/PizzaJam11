extends Control

@export var items:VinylShopItems

var music_index:int = 0
var music:MusicChoice

func _ready():
	items.connect("item_bought", _on_item_bought)

func _physics_process(delta):
	pass
	
func update_shown():
	var i:int = 0
	for child:MusicChoice in $items.get_children():
		child.visible = true
		if i == music_index-1:
			child.global_position = $last.position
		elif i == music_index:
			child.global_position = $current.position
		elif i == music_index+1:
			child.global_position = $next.position
		else:
			child.visible = false
			
		i += 1
		
func update_music():
	Sound.current_music = music.stream
		
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
		music_index = (music_index - 1)%$items.get_child_count()
		update_shown()
	if ev.is_action_pressed("mus_next"):
		music_index = (music_index + 1)%$items.get_child_count()
		update_shown()
