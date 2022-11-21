extends KinematicBody2D

export (int) var damage = 20

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 40

var flag=0
var turn_around

var coins =preload ("res://Scena/Coins.tscn")

var lives=5



var motion = Vector2()

func _ready():
	$AnimatedSprite.scale.x = 1
	motion.x = SPEED
	
func _process(_delta):
	
	hit()
	
func _physics_process(_delta):
	
	if lives <=0:
		$AnimatedSprite.play("Death")
		print  ("DEathh")
		yield(get_tree().create_timer(1.0),"timeout")
		queue_free()
		new_coins()
		
		
	elif $Att_R_ray.is_colliding():
		motion.x =0
		if $AnimatedSprite.flip_h==true:
			flag=1
			$AnimatedSprite.flip_h=false
		$Hit_R/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-71
		$AnimatedSprite.play("Attack1")
		yield(get_tree().create_timer(1.5),"timeout")
		$Hit_R/CollisionShape2D.disabled=true
		"""if flag==2:
			$AnimatedSprite.flip_h=true
			flag=0"""
		#$Hit_R/CollisionShape2D.disabled=true 
		#$AnimatedSprite.position.y=-49
		#motion.x = SPEED
		
		
	elif $Att_L_ray.is_colliding():
		motion.x = 0
		if $AnimatedSprite.flip_h==false:
			flag=2
			$AnimatedSprite.flip_h=true
		$Hit_L/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-71
		$AnimatedSprite.play("Attack1")
		yield(get_tree().create_timer(1.5),"timeout")
		$Hit_L/CollisionShape2D.disabled=true
		"""if flag==1:
			$AnimatedSprite.flip_h=false
			flag=0"""
		#$Hit_L/CollisionShape2D.disabled=true 
		#$AnimatedSprite.position.y=-49
		#motion.x = SPEED
		
	else:
		
		if is_on_wall():
			turn_around=not turn_around
			
		elif flag==1:
			turn_around=false
			#$AnimatedSprite.flip_h=true
			flag=0
		elif flag==2:
			turn_around=true
			$AnimatedSprite.flip_h=false
			flag=0
			
		"""elif turn_around==true:
			motion.x = SPEED
			$AnimatedSprite.position.y=-49
			$AnimatedSprite.play ("Walk")
			$AnimatedSprite.flip_h=false
			
		elif turn_around==false:
			motion.x = SPEED
			$AnimatedSprite.position.y=-49
			$AnimatedSprite.play ("Walk")
			$AnimatedSprite.flip_h=true"""
		#$Hit_R/CollisionShape2D.disabled=true 
		#$Hit_L/CollisionShape2D.disabled=true 
		
		
		motion.y += GRAVITY
		_move()
		
	motion = move_and_slide(motion)
		
	"""if $Att_L_ray.is_colliding():
			motion.x = -SPEED/5
			_flip()
			$AnimatedSprite.position.y=-71
			$AnimatedSprite.play("Attack2")
			
			motion.x = -SPEED
			_flip()
			
	elif $Att_R_ray.is_colliding():
			motion.x = SPEED/5
			$AnimatedSprite.position.y=-71
			$AnimatedSprite.play("Attack1")
			
			motion.x = SPEED"""
	
	
	
func _next_to_left_wall()->bool:
	#print ("l" +str($Left_Ray.is_colliding()))
	return $Left_Ray.is_colliding()
	
func _next_to_right_wall()->bool:
	#print (str($Right_Ray.is_colliding()))
	return $Right_Ray.is_colliding()
	
func _floor_detection_L ()->bool:
	#print ("FF"+str($AnimatedSprite/Floor_Detection.is_colliding()))
	#print ("Left")
	return $CollisionShape2D/Floor_Detection_L.is_colliding()
	
func _floor_detection_R ()->bool:
	#print ("FF"+str($AnimatedSprite/Floor_Detection.is_colliding()))
	#print ("Right")
	return $CollisionShape2D/Floor_Detection_D.is_colliding()
	
func _flip():
	motion.x *= -1
	$AnimatedSprite.scale.x *= -1
	"""if $AnimatedSprite.flip_h == true:
		motion.x *= -1
		$AnimatedSprite.flip_h=false
		$Left_Ray.enabled=false
		$Right_Ray.enabled=true
	else:
		motion.x *= -1
		$AnimatedSprite.flip_h = true
		$Left_Ray.enabled=true
		$Right_Ray.enabled=false"""
		

func _move():
	if _next_to_left_wall() or _next_to_right_wall() or!_floor_detection_L () or !_floor_detection_R(): 
		motion.x = SPEED
		_flip()

func hit ():
	
	pass
	
func new_coins():
	var area= $Position2D
	var coinsp=coins.instance ()
	get_parent().add_child(coinsp)
	coinsp.position=Vector2(area.global_position.x, area.global_position.y)

func _on_AnimatedSprite_animation_finished():
	

	"""if $AnimatedSprite.play("Death"):
		var area= $Position2D
		var coinsp=coins.instance ()
		get_parent().add_child(coinsp)
		coinsp.position=Vector2(area.global_position.x, area.global_position.y)
		queue_free()"""
	
	"""if $AnimatedSprite.play("Attack1"):
		motion.x = SPEED
		$AnimatedSprite.position.y=-49
		$AnimatedSprite.play("Walk")
		
	if $AnimatedSprite.play("Attack2"):
		motion.x = SPEED
		$AnimatedSprite.position.y=-49
		$AnimatedSprite.play("Walk")
		
		if Input.is_action_pressed("Attack_R"):
			$hit_R/CollisionShape2D.disabled=false
			animationPlayer.flip_h=false
			$AnimatedSprite.play("Attack")
			#$hit_R/CollisionShape2D.disabled=true
			motion.x = min(motion.x + ACC, SPEED)
			print("A")
			attack=true
			
		elif Input.is_action_pressed("Attack_L"):
			$hit_L/CollisionShape2D.disabled=false
			animationPlayer.play("Attack")
			animationPlayer.flip_h=true
			#$hit_L/CollisionShape2D.disabled=true
			print("B")
			attack=true
			
		if animationPlayer.animation=="Attack":
		yield(get_tree().create_timer(0.5),"timeout")
		#animationPlayer.play("Idle")
		attack=false
		print ("D")
		
		else:
			if attack==false:
				animationPlayer.play("Idle")
				$hit_R/CollisionShape2D.disabled=true 
				$hit_L/CollisionShape2D.disabled=true 
		
		"""

	pass # Replace with function body.


func _on_damage_area_entered(area):
	if area.is_in_group ("hit"):
		print("ZZZZZZZZZZZZZZ")
		lives-=1
	pass # Replace with function body.
