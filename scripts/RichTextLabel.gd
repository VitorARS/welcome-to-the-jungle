 extends RichTextLabel
onready var hud_instance = preload("res://prefabs/HUD.tscn")

onready var ok = get_node("../../../ok!")

var dialogue = ["Bem vindo ao tutorial! (clique aqui para continuar)",
"Ok, para darmos o pontapé inicial, que tal usarmos as teclas A e D para nos movermos? (até a bandeira)", 
"Agora vamos usar a tecla W para pular e coletar aquela fruta", "Muito bem, seguiremos em frente. Agora você precisa atravessar aquele abismo",
"Vou lhe apresentar seu maior aliado nesta jornada, seu HUD. que lhe informa sua saúde, pontuação e tempo restante para completar o level",
"Agora você deverá ir até o checkpoint. Ele salvará sua posição caso você morra.", "Agora você deverá enfrentar um inimigo. mate-o pulando em sua cabeça.",
 "Parabéns, você completou o tutorial, se achar que está pronto, clique em jogar em começaremos a aventura."]
var page = 0

func _ready():
	Global.player.set_physics_process(false)
	set_bbcode(dialogue[page])
	set_visible_characters(0)
	set_process_input(true)
	yield(get_tree().create_timer(1.9), "timeout")
	var continuar_button = get_node( "../../../continuar"  )
	continuar_button.visible = true
	


func change_page():
		
		
		if get_visible_characters() > get_total_character_count():
			if page < dialogue.size()-1:
				 page += 1
				 set_bbcode(dialogue[page])
				 set_visible_characters(0)
		else: 
			set_visible_characters(get_total_character_count())
  
func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	
	
	# PASSOS DO TUTORIAl
	
func _on_Button_pressed():
	if get_visible_characters() > get_total_character_count():
		 change_page()
		 Global.player.set_physics_process(true)
		 var button = get_node("../../../continuar")
		 button.queue_free()




func _on_Area2D_body_entered(body):  #andar
	if page == 1:
		if get_visible_characters() > get_total_character_count():
			var anim = get_node("../../../targets" )
			anim.play("noFlag")
			change_page()
			


func _on_apple_body_entered(body):  #coletar fruta
	if get_visible_characters() > get_total_character_count():
		change_page()

func _on_abismo_pulo_body_entered(body): #pular abismo
	if body.name == "player":
		if get_visible_characters() > get_total_character_count():
			change_page()
			Global.player.set_physics_process(false)
			Global.player.anim_p.play("idle")
			var hud = hud_instance.instance()
			get_parent().get_parent().get_parent().add_child(hud)
			Global.player.connectPlayertohud()
			yield(get_tree().create_timer(4.0),"timeout")
			ok.visible = true

func _on_ok_pressed():  #aprender sobre o HUD
		Global.player.set_physics_process(true)
		if page == 4:
			if get_visible_characters() > get_total_character_count():
				change_page()
				ok.queue_free()
				


func _on_checkpoint_tuto_body_entered(body):
	if page == 5:
		if get_visible_characters() > get_total_character_count():
			change_page()

func _on_Hitbox_body_entered(body):
	var mush = get_node( "../../../Mushroom" )
	if mush.health < 2:  #é isso ai
		change_page()
		Global.player.anim = "idle"
		yield(get_tree().create_timer(0.7),"timeout")
		Global.player.set_physics_process(false)
		var jogar = get_node("../../../jogar"  )
		yield(get_tree().create_timer(1.3),"timeout")
		jogar.visible = true
