extends Area2D

var velocity = Vector2.ZERO
export var shoot_speed = -300
var direction = 1


func _physics_process(delta):
	velocity.x = shoot_speed * delta * direction
	if $RayCast2D.is_colliding():
		$AnimationPlayer.play("explosion")

	translate(velocity)


func _on_clear_seed_screen_exited():
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

