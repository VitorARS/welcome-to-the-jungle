extends Node2D

func _ready():
	Global.current_level = 2
	set_physics_process(false)
	Global.can_see_player = false
	$player.send_signal()
	if Global.got_weapon:
		Global.player.arminha.visible = true



