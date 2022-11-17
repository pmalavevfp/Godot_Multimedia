extends Area2D

func _process(delta):
	if Global.door==1:
		$AnimatedSprite.play("Close")
		$CollisionShape2D.disabled=true
		#$CollisionShape2d.disabled=true
	elif Global.door >=2:
		$AnimatedSprite.play("Open")
		$AudioStreamPlayer.play()
		$CollisionShape2D.disabled=false
		#$CollisionShape2d.disabled=false

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group ("player"):
		get_tree().change_scene("res://Scena/Nivel2.tscn")
		

