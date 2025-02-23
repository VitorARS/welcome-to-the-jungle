extends Area2D



func _on_passagem_secreta_body_entered(body):
	if body.name == "player":
		var tile = get_parent().get_node("TileMap2")
		tile.modulate = Color(1, 1,1, 0.85)
		$Label.visible = true


func _on_passagem_secreta_body_exited(body):
	if body.name == "player":
		var tile = get_parent().get_node("TileMap2")
		tile.modulate = Color(1, 1,1,1)
		$Label.visible = false
