extends Area2D

signal player_entered


func _ready():
	Global.set("trigger", self)
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "player":
			emit_signal("player_entered")
			
			queue_free()
