extends Area2D

onready var text = get_node("Control/win")
onready var fruits = get_node("Control/fruits")
onready var kills = get_node("Control/enemyKills")
onready var deaths = get_node("Control/deaths")

var text_siz = 1
func _ready():
	set_physics_process(false)

func _physics_process(delta):
	text.set_text("Parabéns, você venceu o jogo!")
	text.get("custom_fonts/font").set_size(text_siz) 
	text_siz += 0.3
	if text_siz > 28:
		text_siz = 28
	var total_fruits = "Pontuação: " + String(Global.fruits)
	fruits.set_text(total_fruits)
	fruits.get("custom_fonts/font").set_size(text_siz) 
	text_siz += 0.1
	if text_siz > 8:
		text_siz = 8
	var total_deaths = "Mortes: " + String(Global.player_deaths)
	deaths.set_text(total_deaths)
	deaths.get("custom_fonts/font").set_size(text_siz) 
	text_siz += 0.1
	if text_siz > 8:
		text_siz = 8
	var total_kills = "Inimigos abatidos: " + String(Global.player_kills)
	kills.set_text(total_kills)
	kills.get("custom_fonts/font").set_size(text_siz) 
	text_siz += 0.1
	if text_siz > 8:
		text_siz = 8
func _on_final_trigger_body_entered(body):
	if Global.player.is_grounded:
		Global.player.set_physics_process(false)
		Global.player.anim_p.play("idle")
		self.position = Global.player.position
		var hud = get_parent().get_node("HUD")
		hud.queue_free()
		text.visible = true
		set_physics_process(true)
	else:
		yield(get_tree().create_timer(.1),"timeout")
		_on_final_trigger_body_entered(body)
	
