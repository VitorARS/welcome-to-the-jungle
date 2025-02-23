extends Node2D

var checkpoint_pos = 0
var cc = 0.50

func _physics_process(delta):
	
	cc += 0.02

	$ParallaxBackground/moving_clouds/Sprite.modulate = Color(cc,cc,cc)

	$ParallaxBackground/clouds_montain/Sprite.modulate = Color(cc,cc,cc)

	$ParallaxBackground/montain_trees/Sprite.modulate = Color(cc,cc,cc)

	$ParallaxBackground/trees/Sprite.modulate = Color(cc,cc,cc)
	
	$ParallaxBackground/sky/Sprite.modulate = Color(cc,cc,cc)
	if cc  > 1:
		cc = 1
		set_physics_process(false)
	
func _ready():
	Global.current_level = 3
	set_physics_process(false)
	Global.can_see_player = false
	$player.send_signal()
	if Global.got_weapon:
		Global.player.arminha.visible = true



func _on_Trigger_player_entered_camera():
	$cam_anim.play("setting")
	$Boss_Camera.current = true
	


func _on_Boss_dead():
	$Boss_Camera.current = false
	
	yield(get_tree().create_timer(3),"timeout")
	set_physics_process(true)
	$funk.play()
