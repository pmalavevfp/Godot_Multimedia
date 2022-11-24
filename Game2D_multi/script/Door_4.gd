extends Area2D

func _process(delta):
	if Global.count_door==3 && Global.count_keys==2:
		$AnimatedSprite.play("Close")
		$CollisionShape2D.disabled=true
		
	elif Global.count_door >=3&& Global.count_keys==3:
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(0.3),"timeout")
		$AnimatedSprite.play("Open")
		$CollisionShape2D.disabled=false


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group ("player"):
		get_tree().change_scene("res://Scena/Win.tscn")
		
