extends Control

onready var fileira = $TextureRect
onready var fileira2 = $TextureRect2
var cell_x = 10
var cell_y = 16


func _ready():
	ajust_ammo()



func _on_arma2_got_weapon():
	ajust_ammo()


func _on_ammo_item_ammo_item():
	ajust_ammo()


func _on_player_shoot():
	ajust_ammo()

func ajust_ammo():
	if Global.ammo >= 10:
		Global.ammo = 10
	if Global.ammo <= 5  and Global.ammo > 0:
		fileira.visible = true
		fileira2.visible = false
		fileira.rect_size.x = Global.ammo * cell_x
	if Global.ammo >5:
		fileira.visible = true
		fileira2.visible = true
		fileira.rect_size.x = cell_x * 5
		fileira2.rect_size.x = Global.ammo * cell_x - 50
	if Global.ammo == 0:
		fileira.visible = false
	
