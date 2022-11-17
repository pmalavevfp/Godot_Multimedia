extends Node2D



func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group ("player"):
		Global.count_lives +=30
		yield(get_tree().create_timer(0.3),"timeout")
		queue_free()
