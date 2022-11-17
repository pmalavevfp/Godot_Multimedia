extends CanvasLayer


func _process(_delta):
	#$Label.text=str(get_parent().coins)
	$Label.text=str(Global.count_coins)
	$Label2.text=str(Global.count_keys)
	if Global.count_lives >=0:
		if Global.count_lives in range(80,101):
			$Heart/AnimatedSprite.play("heart100")
		if Global.count_lives in range(60,80):
			$Heart/AnimatedSprite.play("heart80")
		if Global.count_lives in range(40,60):
			$Heart/AnimatedSprite.play("heart60")
		if Global.count_lives in range(20,40):
			$Heart/AnimatedSprite.play("heart40")
		if Global.count_lives in range(1,20):
			$Heart/AnimatedSprite.play("heart20")
	else:
		$Heart/AnimatedSprite.play("heart0")
		
