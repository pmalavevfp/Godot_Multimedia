extends Area2D


func _ready():
	$AnimatedSprite.play ("close")

func _on_Chest_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		$AudioStreamPlayer.play()
		$AnimatedSprite.play ("Open")
		get_parent().coins +=15
		get_node ("CollisionShape2D").queue_free()
	
