extends enemy_base
func _physics_process(delta):
	set_gravity(delta)
	
	if $DetectionZone.can_see_player == true:

		Global.can_see_player = true
		velocity = move_and_slide(velocity * 1.33)

		if  health < 1:
			Global.can_see_player = false
			
		if $RayWall.is_colliding():
			$anim.play("chase")
			move_direction *= -1
			$anim.play("Correndo")
			$RayWall.scale.x *= -1
			
			
	else:
		Global.can_see_player = false
		

	


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
		get_node("Hitbox/Collision") .set_deferred("disable", true)

