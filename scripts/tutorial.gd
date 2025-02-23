extends Node2D

func _ready():
	Global.current_level = 0


func _on_jogar_pressed():
	get_tree().change_scene("res://levels/level_01.tscn")
	Global.checkpoint_pos = 0
