extends Area2D


func _ready():
	$AnimatedSprite.play ("close")
	
func inspect ():
	OS.alert("Recibiras 30 coins y 30 lifes")
	$AudioStreamPlayer.play()
	$AnimatedSprite.play ("Open")
	Global.count_coins +=30
	Global.count_lives +=30
	get_node ("CollisionShape2D").queue_free()
	
