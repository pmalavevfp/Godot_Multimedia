extends Node2D

func _on_Area2D_body_entered(body):
	if body.is_in_group ("player"):
		#print ("player detectado")
		#get_parent().coins +=1
		#body.contadorMonedas += 1
		#print(body.contadorMonedas)
		Global.count_coins +=1
		print (Global.count_coins)
		queue_free()
