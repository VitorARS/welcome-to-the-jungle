
extends CanvasLayer


func _ready():
	set_visible(false)

func _input(event):
	
	if event.is_action_pressed("ui_cancel"): # escape button by default
		set_visible(!get_tree().paused) # if not pause then hide
		get_tree().paused = !get_tree().paused # toggle pause status




	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible





func _on_continuar_pressed():
	get_tree().paused = false
	set_visible(false)


func _on_sair_pressed():
	get_tree().change_scene("res://levels/start_screen.tscn")
