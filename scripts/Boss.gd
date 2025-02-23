extends KinematicBody2D

export var speed = 70
export var health = 3
var move_direction = -1
var velocity = Vector2.ZERO
var gravity = 1200
onready var child_instance = preload("res://Enemies_tcsn/Boss_children.tscn")
signal dead
onready var sprite = $Sprite
var hitted = false
var jumping_time = false
var idle = true
var jumping = false
var invincible = false
enum state {IDLE, RUNNING, DAMAGE, JUMPING, DEAD, INVINCIBLE}

var boss_state = state.IDLE

func boss_moviment():
	velocity.x = speed * move_direction


func _physics_process(delta):
	if jumping == false and hitted == false:
		boss_moviment()
		set_boss_animation()
		if $RayWall.is_colliding():
			boss_state = state.IDLE
		elif jumping_time == true:
			boss_state = state.JUMPING
	set_gravity(delta)
	velocity = move_and_slide(velocity)

func set_gravity(delta):
		velocity.y += gravity * delta

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Parado":
		$RayWall.scale.x *= -1
		move_direction *= -1
		boss_state = state.RUNNING


func _on_Hitbox_body_entered(body):
	if invincible == false:
		hitted = true
		$anim.play("Dano")
		Global.player.velocity.y = Global.player.jump_force / 2
		health -= 1
		print(health)
		$hit_fx.play()
		yield(get_tree().create_timer(0.25),"timeout")
		hitted = false
	else: 
		Global.player.velocity.y = Global.player.jump_force / 1.4
	if $RayWall.is_colliding():
		$anim.play("Parado")
	else:
		$anim.play("Correndo")
	if health > 1:
		invincible()
	elif health < 1:
		boss_state = state.DEAD
	
func _ready():
	set_physics_process(false)
	
func _on_ArenaDoor_DoorClosed():
	set_physics_process(true)
	yield(get_tree().create_timer(10.0),"timeout")
	jumping = true
	jumping()
	
	

#
#
func set_boss_animation():
	if move_direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	match(boss_state):
		state.IDLE:
			$anim.play("Parado")
#			idle = true
		state.RUNNING:
			if health < 4:
				speed = 90
				$anim.play("angryRun")
			else:
				$anim.play("Correndo")
		state.DEAD:
			set_physics_process(false)
			get_node("Hitbox/Collision").disabled = true
			get_node("collision").disabled = true
			$anim.play("die")
			Global.player_kills += 1
			yield(get_tree().create_timer(1), "timeout")
			emit_signal("dead")
			queue_free()


func _on_start_screen_boss_ready():
	set_physics_process(true)
	health = 1

func jumping():
	set_physics_process(false)
	speed = 0
	$collision.disabled = true
	$Hitbox/Collision.disabled = true
	$anim.play("jump")
	yield(get_tree().create_timer(1.0),"timeout")
	set_physics_process(true)
	var child = child_instance.instance()
	var child2 = child_instance.instance()
	get_parent().add_child(child)
	child.global_position = Vector2( rand_range(950, 1170), 145)
	get_parent().add_child(child2)
	child2.global_position = Vector2( rand_range(950, 1170), 145)
	velocity.y = -2000
	yield(get_tree().create_timer(.3),"timeout")
	$collision.disabled = false
	$Hitbox/Collision.disabled = false
	yield(get_tree().create_timer(2.7),"timeout")
	$anim.play("Correndo")
	speed = 64
	jumping = false
#	yield(get_tree().create_timer(3.0),"timeout")
#	boss_state = state.INVINCIBLE
	yield(get_tree().create_timer(8.0),"timeout")
	jumping = true
	jumping()
	
func invincible():
				invincible = true
				$Collected.visible = true
				$collected_anim.play("invincible")
				yield(get_tree().create_timer(3.0), "timeout")
				$Collected.visible = false
				invincible = false
				if $RayWall.is_colliding():
					boss_state = state.IDLE
				else:
					boss_state = state.RUNNING



func _on_Hitbox_area_entered(area):
	hitted = true
	health -= 1
	$hit_fx.play()
	area.queue_free()
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		queue_free()
		get_node("Hitbox/Collision").disabled = true 
