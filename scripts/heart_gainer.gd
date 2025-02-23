extends Area2D

export var heart = 1
onready var player = get_node("../../player")



func _on_heart_gainer_body_entered(body):
	if Global.player_health < 3:
		 Global.player_health += heart
		 player.send_signal()
		 $anim.play("collected")



func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
	
	

