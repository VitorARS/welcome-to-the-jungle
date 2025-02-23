extends Area2D




func _on_Fall_zone_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://prefabs/GameOver.tscn")
