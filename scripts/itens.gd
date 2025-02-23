extends Area2D

export var fruits = 1

func _on_Items_body_entered(body):
	Global.fruits += fruits
	$Animation.play("Collected")
	$collected_fx.play()

func _on_Animation_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
