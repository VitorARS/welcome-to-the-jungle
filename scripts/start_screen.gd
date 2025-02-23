extends Control
var play_anim = true
signal boss_ready()


	
func _ready():
	calling_boss()
	$pink_floyd.play()
	$anim2.play("apple")
	$controls/start.grab_focus()
	yield(get_tree().create_timer(5.0), "timeout")
	$anim.play("birdie")


func _on_anim_animation_finished(birdie):
	if play_anim:
		$anim.play("playerAction")
		yield(get_tree().create_timer(1.4),"timeout")
		$anim2.play("collected")
		play_anim = false

func calling_boss():
	yield(get_tree().create_timer(36.9), "timeout")
	emit_signal("boss_ready")
	yield(get_tree().create_timer(1), "timeout")
	$confetti.emitting = true
	$confetti2.emitting = true



func _on_start_pressed():
	$anim3.play("camera_up")


func _on_contr_pressed():
	$anim3.play("camera")


func _on_quit_pressed():
	 get_tree().quit


func _on_voltar_pressed():
	$anim3.play_backwards("camera")

func _on_creditos_pressed():
	$anim3.play("camera_left")

func _on_voltar2_pressed():
	$anim3.play_backwards("camera_left")




func _on_voltar3_pressed():
		$anim3.play_backwards("camera_up")


func _on_jogar_pressed():
	get_tree().change_scene("res://prefabs/levelprimeiro.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene("res://levels/tutorial.tscn")
