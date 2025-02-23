extends StaticBody2D

signal DoorClosed

func _ready():
	pass


func _on_Trigger_player_entered():
	$collision.disabled = false
	$Collision2.disabled = false
	$anim.play("active")
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("DoorClosed")


func _on_Boss_dead():
	$anim.play_backwards("active")
	$collision.disabled = true
	$Collision2.disabled = true
