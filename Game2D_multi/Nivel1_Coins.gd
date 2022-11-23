extends Node2D

func _ready():
	OS.center_window()

	
func _on_Timer_timeout():
	get_tree().change_scene("res://Scena/Intro.tscn")
