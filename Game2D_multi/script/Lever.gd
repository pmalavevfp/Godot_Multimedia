extends Area2D


func _ready():
	$AnimatedSprite.play("Close")
	


func _on_Lever_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		$AnimatedSprite.play ("Open")
		Global.door +=1
		print(str(Global.door))
