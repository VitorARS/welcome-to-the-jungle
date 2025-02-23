extends KinematicBody2D

export var speed = 64
export var health = 3
var move_direction = -1
var velocity = Vector2.ZERO
var gravity = 1200
signal dead

onready var sprite = $Sprite
var hitted = false





func _ready():
	var boss_node = get_node("../Boss")
	boss_node.connect("dead", self, "on_boss_dead")


func _physics_process(delta):
	velocity.x = speed * move_direction
	set_gravity(delta)
	set_boss_animation()
	

	
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
		die()

func die():
	get_node("Hitbox/Collision").set_deferred("disable", true)
	get_node("collision").set_deferred("disable", true)
	set_physics_process(false)
	$anim.play("die")
	Global.player_kills += 1
	get_node("Hitbox/Collision").set_deferred("disable", true)
	get_node("collision").set_deferred("disable", true)
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("dead")
	queue_free()











func set_boss_animation():

	var anim = "Correndo"

	if $RayWall.is_colliding():
		anim = "Parado"
		
#	elif velocity.x != 0 and health > 3:
#		anim = "Correndo"
	elif velocity.x != 0:# and health < 3:
		anim = "angryRun"
		speed = 90
	if hitted:
		anim = "Dano"
	if $anim.assigned_animation != anim:
		
		$anim.play(anim)

func on_boss_dead():
	die()




func _on_Hitbox_area_entered(area):
	hitted = true
	health -= 1
	$hit_fx.play()
	area.queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		Global.player_kills += 1
		queue_free()
		get_node("Hitbox/Collision").disabled = true 
