extends Label

func _physics_process(delta):
	text = "00" + String(Global.player_kills)
	if Global.player_kills > 9:
		text = "0" + String(Global.player_kills)
