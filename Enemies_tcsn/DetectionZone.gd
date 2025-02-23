extends Area2D
onready var wander = get_parent().get_node("wander")

var can_see_player = false


func _on_DetectionZone_body_entered(body):
	can_see_player = true
	if can_see_player == true:
		yield(get_tree().create_timer(0.1), "timeout")
		play_fx()


func _on_DetectionZone_body_exited(body):
	can_see_player = false
	wander.playing = false
	
func play_fx():
	wander.play()
#	yield(get_tree().create_timer(3.0), "timeout")
