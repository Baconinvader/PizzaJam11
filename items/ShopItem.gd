extends Node

class_name ShopItem

var bought:bool = false

@export var item_name:String
@export var item_description:String
@export var icon:Texture2D
@export_range(0,1000) var cost:int
@export var stream:AudioStream

signal bought_item

func buy():
	g.player.money -= cost
	emit_signal("bought_item")
	bought = true
