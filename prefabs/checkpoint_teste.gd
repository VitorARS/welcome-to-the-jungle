extends Area2D

func _ready():
	pass

func _on_checkpoint_body_entered(body: Node) -> void:
	 
	Global.player.hit_checkpoint()
	$anim.play("checked")
	$check_fx.play()
	yield(get_tree().create_timer(0.7), "timeout")
#	$check_fx.playing = false
	$check_fx.queue_free()
	$collision.queue_free()
