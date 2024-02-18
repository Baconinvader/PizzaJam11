extends Control

var text:String = "":set=_set_text

func _set_text(val:String):
	text = val
	$text.text = text

func _physics_process(delta):
	var shown:bool = false
	for interactable:Interactable in get_tree().get_nodes_in_group("interactables"):
		if interactable.can_interact:
			show_prompt(interactable.prompt_text)
			shown = true
			break
	if not shown:
		hide_prompt()

func show_prompt(prompt_text:String):
	if not visible:
		text = prompt_text
		visible = true

func hide_prompt():
	if visible:
		visible = false
