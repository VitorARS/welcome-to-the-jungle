extends Area2D

onready var changer = get_parent().get_node("transition_in")
export var path : String
func _ready():
	pass


func _on_goal_body_entered(body):
	
	if body.name == "player":
		$confetti.emitting = true
		yield(get_tree().create_timer(2.0), "timeout")
		$confetti.emitting = false
		if Global.current_level == 1:
			changer.change_scene("res://levels/level_02.tscn")
		if Global.current_level == 2:
			changer.change_scene("res://levels/boss.tscn")
		Global.checkpoint_pos = 0
		$victory_fx.play()
