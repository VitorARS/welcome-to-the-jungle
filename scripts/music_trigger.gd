extends Area2D

onready var  bg_music = get_parent().get_node("bg_music")

func _on_music_trigger_body_entered(body):
	if body.name == "player":

		 bg_music.playing = false
		 $boss_music.playing = true
		
		 $collision.queue_free()


func _on_Boss_dead():
	$boss_music.playing = false
	bg_music.playing = true
