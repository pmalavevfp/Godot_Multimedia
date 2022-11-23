extends Node2D

func _ready():
	OS.center_window()

func _on_Play_pressed():
	get_tree().change_scene("res://Scena/Level_1.tscn")
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
