extends enemy_base

func _physics_process(delta):
	velocity.y = 0
	if $RayWall.is_colliding():
		$RayWall.scale.x *= -1
		move_direction *= -1
		$anim.play("Correndo")


func _on_Hitbox_area_entered(area):
	hitted = true
	health -= 1
	$hit_fx.play()
	area.queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		Global.player_kills += 1
		queue_free()
		get_node("Hitbox/Collision").disabled = true 
