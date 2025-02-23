extends CanvasLayer



func _on_btn_again_pressed():

	if Global.current_level == 0:
		get_tree().change_scene("res://levels/tutorial.tscn")
	if Global.current_level == 1:
		get_tree().change_scene("res://prefabs/levelprimeiro.tscn" )
	elif Global.current_level ==2:
		get_tree().change_scene("res://levels/level_02.tscn")
	if Global.current_level == 3:
		get_tree().change_scene("res://levels/boss.tscn"  )
	if Global.is_dead:
		Global.player_health = 3
func _ready():
	$gameover.play()
	yield(get_tree().create_timer(2.0), "timeout")
	$gameover.playing = false
	
	
