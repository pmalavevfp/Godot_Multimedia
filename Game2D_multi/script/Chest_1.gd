extends Area2D


func _ready():
	$AnimatedSprite.play ("close")

func _on_Chest_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		$AudioStreamPlayer.play()
		$AnimatedSprite.play ("Open")
		Global.count_coins +=30
		Global.count_lives +=30
		get_node ("CollisionShape2D").queue_free()
	
