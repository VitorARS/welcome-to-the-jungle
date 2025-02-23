extends Node2D
func _physics_process(delta):
	$music.volume_db += .8
	if $music.volume_db > 0:
		$music.volume_db = 0
		

func _ready():
	$music.volume_db = -70
	
	$confetti.emitting = true
	$confetti2.emitting = true
	$confetti3.emitting = true
	yield(get_tree().create_timer(15.0), "timeout")
	$anim.play("submarine")


func _on_transition_out_transition_fineshed():
	$CanvasLayer/ColorRect.visible = false
