extends Node2D



func _on_Area2D_body_entered(body):
	if body.is_in_group ("player"):
		#print ("player detectado")
		#get_parent().keys +=1
		#body.contadorMonedas += 1
		#print(body.contadorMonedas)
		Global.count_keys +=1
		yield(get_tree().create_timer(0.3),"timeout")
		queue_free()
	
