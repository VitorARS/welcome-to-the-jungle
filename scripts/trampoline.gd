extends Area2D

export var resistence = 1.1


func _on_trampoline_body_entered(body):
	body.velocity.y = body.jump_force / resistence
	$anim.play("jump")
