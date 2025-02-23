extends Label



func _physics_process(delta):
	text = "000" + String(Global.fruits)
	if Global.fruits > 9:
		text = "00" + String(Global.fruits)
