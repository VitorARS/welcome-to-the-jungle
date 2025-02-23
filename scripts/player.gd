extends KinematicBody2D
 #seção de variaveis
var move_direction 
var facing_left = false
var up = Vector2.UP
var is_grounded
var velocity = Vector2.ZERO
var move_speed = 500
var gravity = 1180
var jump_force = -750
onready var raycasts = $Raycasts
onready var arminha = $arminha
var atrito = 0.2
var is_pushing
var max_health = 3
var hurted = false
var knockback_dir = 1
var knockback_int = 2000
var anim
var aim = false
signal change_life(player_health)
signal shoot
onready var anim_p = $anim
onready var bullet_instance = preload("res://Player/ammo.tscn")
onready var shotAndroid = preload("res://prefabs/shot_android.tscn")
func _ready():
	
	Global.set("player", self)

	position.x = Global.checkpoint_pos
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/holder"), "on_change_life")
	emit_signal("change_life", max_health)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = 0
	if !hurted:
		get_input()
	
	if $push_right.is_colliding():
		is_pushing = true
		var object = $push_right.get_collider()
		object.move_and_slide(Vector2(30, 0)) * move_speed * delta
	elif $push_left.is_colliding():
		is_pushing = true
		var object = $push_left.get_collider()
		object.move_and_slide(Vector2(-30, 0)) * move_speed * delta
	else:
		is_pushing = false
		
	if is_grounded:
		$shadow.visible = true
	else:
		$shadow.visible = false
	is_grounded = check_is_ground()
	set_animation()
	
	velocity = move_and_slide(velocity, up)
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
	if Global.got_weapon and anim_p.assigned_animation != "aim":
		arminha.visible = true
#        movimentação do jogador
func get_input():
	velocity.x = 0
	move_direction= int(Input.is_action_pressed("move_right")) - int (Input.is_action_pressed("move_left"))
	velocity.x = lerp( velocity.x, move_speed * move_direction, atrito)
	
	if move_direction !=0:

		$texture.scale.x = move_direction
		knockback_dir = move_direction
		$steps_fx.scale.x = move_direction
		$arminha.scale.x = move_direction * 0.17
		$arminha.rotation_degrees = move_direction * 90
		if move_direction == -1:
			facing_left = true
			$spawnShoot.position.x = -30
			$texture.position.x = -8
			$Hurtbox.position.x = -8
			$CollisionShape2D.position.x = -8
		else:
			$spawnShoot.position.x = 30
			facing_left = false
			$texture.position.x = 0
			$Hurtbox.position.x = 0
			$CollisionShape2D.position.x = 0
			
	if velocity.x > -1:
		$push_right.set_enabled(true)
	else:
		$push_right.set_enabled(false)
	if velocity.x < 1:
		$push_left.set_enabled(true)
	else:
		$push_left.set_enabled(false)

  #          Pular
func _input( event:InputEvent):
	if event.is_action_pressed("move_up") and is_grounded:
		velocity.y = jump_force/2
		$jump_fx.play()
	if event.is_action_pressed("shoot") and Global.got_weapon:
		if is_grounded and Global.ammo >0 :
			shoot()
	
func check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false



#  Aplicar a animação

func set_animation():

	if velocity.x == 0 and aim == false:
		 anim = "idle"
		
	
	
	if !is_grounded:
		anim = "jump"
		aim = false
	
	elif velocity.x != 0 or is_pushing:
		anim = "run"
		aim = false
		$steps_fx.set_emitting(true)
		
	if velocity.y > 0 and !is_grounded:
		anim = "fall"
		aim = false

	if hurted:
		anim = ("hit")
		aim = false
	
	if anim_p.assigned_animation != anim:
		anim_p.play(anim)

  #				 DAno do Jogador
func _on_Hurtbox_body_entered(body):
	player_damage()


func knockback():
	if $right.is_colliding():
		velocity.x = -1 * knockback_int
		print(velocity.x)
		
	if $left.is_colliding():
		velocity.x = 1 * knockback_int
		print(velocity.x)
	velocity = move_and_slide(velocity)
	
func hit_checkpoint():
	Global.checkpoint_pos = global_position.x


func _on_headCollider_body_entered(body):
	if body.has_method("destroy"):
		body.destroy()


func _on_Hurtbox_area_entered(area):
	 player_damage()
	
func player_damage():
	
	hurted = true
	knockback()
	Global.player_health -= 1
	send_signal()
	get_node("Hurtbox/CollisionShape2D").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("Hurtbox/CollisionShape2D").set_deferred("disabled", false)
	hurted = false
	game_over()



func send_signal():
	emit_signal("change_life", Global.player_health)
	
func game_over() -> void:
	if Global.player_health < 1:
		Global.player_deaths += 1
		queue_free()
		Global.is_dead = true
		get_tree().change_scene("res://prefabs/GameOver.tscn")
		


func _on_Trigger_player_entered():
	 $Camera2D.current = false



func _on_Boss_dead():
	yield(get_tree().create_timer(1.5), "timeout")
	$Camera2D.current = true

func connectPlayertohud():
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/holder"), "on_change_life")
	emit_signal("change_life", max_health)


func shoot():
	set_physics_process(false)
	Global.ammo -= 1
	emit_signal("shoot")
	if aim == false:
		anim_p.play("shoot")
		yield(get_tree().create_timer(0.5), "timeout")
	else: 
		anim_p.play("aim")
		yield(get_tree().create_timer(0.1), "timeout")
	var bullet = bullet_instance.instance()
	get_parent().add_child(bullet)
	bullet.global_position = $spawnShoot.global_position
	if facing_left:
		bullet.direction = 1
	else:
		bullet.direction = -1
	set_physics_process(true)
	if Global.ammo >0:
		aim = true
		anim = "aim"

func _on_arma2_got_weapon():
	var android = shotAndroid.instance()
	get_parent().add_child(android)
	Global.ammo = 5
	$arminha.visible = true
	Global.got_weapon = true

