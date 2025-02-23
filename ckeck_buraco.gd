extends Area2D

onready var changer = get_parent().get_node("transition_in")


func _on_ckeck_buraco_body_entered(body):
	if body.name == "player":
		$anim.play("collected")
		$CollisionShape2D.queue_free()
		changer.just_transition()
		yield(get_tree().create_timer(2.0), "timeout")
		body.global_position =Vector2(822, -222)

