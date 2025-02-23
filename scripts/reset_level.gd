extends Node2D

func _ready():
	Global.current_level = 1
	set_physics_process(false)
	Global.player_kills = 0
	Global.fruits = 0
	Global.player_health = 3
	Global.can_see_player = false
	$player.send_signal()

	
