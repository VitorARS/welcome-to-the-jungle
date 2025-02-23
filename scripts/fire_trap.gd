extends Area2D

onready var player = Global.get("player")


func _on_fire_body_entered(body):
	player.player_damage()


func _on_start_timer_timeout():
	$anim.play("on")
	$fire_coll.set_deferred("disabled", false)




func _on_stop_timer_timeout():
	$anim.play("off")
	$fire_coll.set_deferred("disabled", true)
