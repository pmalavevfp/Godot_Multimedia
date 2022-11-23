extends Node2D

var coins : int =0
var keys : int =0

func _ready():
	OS.center_window()
	

func _on_Player_player_spacebar(area):
	if area !=null:
		area.inspect()
