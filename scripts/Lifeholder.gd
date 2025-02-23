extends Control

var life_size = 32

func _ready():
		$lifes.rect_size.x =  3 * life_size #teste
	
func on_change_life(player_health):
	$lifes.rect_size.x =  player_health * life_size

