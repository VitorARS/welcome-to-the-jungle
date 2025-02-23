extends Area2D



signal got_weapon

func _on_arma_body_entered(body):
	$AnimationPlayer.play("collected")
func _ready():
	if Global.got_weapon:
		queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("got_weapon")
	queue_free()
