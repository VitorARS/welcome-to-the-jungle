extends KinematicBody2D
class_name enemy_base

export var speed = 64
export var health = 3
var move_direction = -1
var velocity = Vector2.ZERO
var gravity = 1200


onready var sprite = $Sprite
var hitted = false


func _physics_process(delta):
	velocity.x = speed * move_direction
	
	
	set_animation()
	
	if move_direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


	velocity = move_and_slide(velocity)

func set_gravity(delta):
		velocity.y += gravity * delta

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Parado" or "chase":
		$RayWall.scale.x *= -1
		move_direction *= -1
		$anim.play("Correndo")

func set_animation():
	var anim = "Correndo"
	if $RayWall.is_colliding() and Global.can_see_player == false:
		anim = "Parado"
		
	elif velocity.x != 0:
		anim = "Correndo"
	if hitted:
		anim = "Dano"
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func _on_Hitbox_body_entered(body):
	hitted = true
	body.velocity.y = body.jump_force / 2
	health -= 1
	$hit_fx.play()
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		Global.player_kills += 1
		queue_free()
		get_node("Hitbox/Collision") .set_deferred("disable", true)
		


