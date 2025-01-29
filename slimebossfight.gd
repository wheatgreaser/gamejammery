extends Node2D
var clone_speed_1 = 100
var clone_speed_2 = -100
var flag2 = 0
var SPEED = 100

func _process(delta):
	if(Global.isSlime1Dead == 1 && Global.isSlime2Dead == 1):
		get_tree().change_scene_to_file("res://youwin.tscn")
		

