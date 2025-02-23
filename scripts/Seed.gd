extends Area2D

var velocity = Vector2.ZERO
export var shoot_speed = -100
var direction = 1
   
func _physics_process(delta):
	velocity.x = shoot_speed * delta * direction

	translate(velocity)


func _on_clear_seed_screen_exited():
	queue_free()


