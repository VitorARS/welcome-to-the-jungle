extends Area2D

signal ammo_item
var foi_pega

func _on_Animation_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()


func _on_ammo_item_body_entered(body):
	foi_pega = true
	$Animation.play("Collected")
	$collected_fx.play()
	Global.ammo += 3
	emit_signal("ammo_item")
