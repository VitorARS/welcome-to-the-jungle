extends Area2D

onready var explosion_instance = preload("res://prefabs/explosion.tscn")


func _on_Lucy_fx_body_entered(body):
	if body.name == "player":
		var bg_music = get_parent().get_node("bg_music")
		bg_music.playing = false
		$AudioStreamPlayer2D.playing = true
		yield(get_tree().create_timer(.2), "timeout")
		Global.player.set_physics_process(false)
		Global.player.anim_p.play("run")
		$anim.play("submarine")
		$Collision.queue_free()
		yield(get_tree().create_timer(5.2), "timeout")

		
		$AudioStreamPlayer2D.playing = false
		var explosion =  explosion_instance.instance()
		Global.player.add_child(explosion)
		Global.player.gravity = 1100
#		Global.in_sky = false
		Global.player.set_physics_process(true)
		yield(get_tree().create_timer(0.6),"timeout")
		body.global_position =Vector2(822, -222)
		bg_music.playing = true
		
		
		
		




