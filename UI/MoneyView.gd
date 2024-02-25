extends Control

var old_money:float = 0
var increase_speed = 1.0

func _physics_process(_delta):
	if old_money != g.player.money:
		show_money_increase(g.player.money-old_money)
		old_money = g.player.money
	$text.text = "Money: $%s" % g.player.money

func _process(delta):
	if $increase.visible:
		$increase.position.y -= increase_speed

func show_money_increase(amount:float):
	if amount > 0:
		Sound.play_sound("sell")
		$increase.text = "+$%s" % amount
		$increase.set("theme_override_colors/font_color", Color(0,1,0,1))
	else:
		Sound.play_sound("buy")
		$increase.text = "-$%s" % -amount
		$increase.set("theme_override_colors/font_color", Color(1,0,0,1))
	$increase.position.y = 0
	$increase.visible = true
	$increase_timer.start()


func _on_increase_timer_timeout():
	$increase.visible = false
	$increase.position.y = 0
