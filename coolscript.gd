extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.isSlimeDead == 1):
			get_tree().change_scene_to_file("res://bossphase2.tscn")


func _on_timer_3_timeout():
		pass
	
