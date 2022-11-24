extends Node2D

func _ready():
	OS.center_window()

func _on_Play_pressed():
	get_tree().change_scene("res://Scena/Level_1.tscn")
	


func _on_Exit_pressed():
	get_tree().quit()
	
