extends KinematicBody2D


export (int) var damage = 20

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 40

var flag=0
var turn_around=false

var coins =preload ("res://Scena/Coins.tscn")

var lives=5



var motion = Vector2()

func _ready():
	$AnimatedSprite.scale.x = 1
	motion.x = SPEED
	
func _process(_delta):
	
	hit()
	
func _physics_process(_delta):
	
	motion.y += GRAVITY
	_move()

	motion = move_and_slide(motion)
	
	
	if lives <=0:
		$AnimatedSprite.play("Death")
		#print  ("DEathh")
		yield(get_tree().create_timer(1.0),"timeout")
		queue_free()
		new_coins()
		
		
	elif $Att_R_ray.is_colliding():
		
		if $AnimatedSprite.flip_h==true:
			_flip()
			motion.x=0
		$Hit_R/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-71
		$AnimatedSprite.play("Attack1")
		yield(get_tree().create_timer(0.9),"timeout")
		$Hit_R/CollisionShape2D.disabled=true
		"""if flag==2:
			$AnimatedSprite.flip_h=true
			flag=0"""
		#$Hit_R/CollisionShape2D.disabled=true 
		#$AnimatedSprite.position.y=-49
		#motion.x = SPEED
		
		
	elif $Att_L_ray.is_colliding():
	
		if $AnimatedSprite.flip_h==false:
			_flip()
			motion.x=0
		$Hit_L/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-71
		$AnimatedSprite.play("Attack1")
		yield(get_tree().create_timer(0.9),"timeout")
		$Hit_L/CollisionShape2D.disabled=true
		"""if flag==1:
			$AnimatedSprite.flip_h=false
			flag=0"""
		#$Hit_L/CollisionShape2D.disabled=true 
		#$AnimatedSprite.position.y=-49
		#motion.x = SPEED

	
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
	#$AnimatedSprite.scale.x *= -1
	if $AnimatedSprite.flip_h==true:
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true

func _move():
	if _next_to_left_wall() or _next_to_right_wall() or!_floor_detection_L () or !_floor_detection_R():
	#if !_floor_detection_L () or !_floor_detection_R(): 
		_flip()
		
func hit ():
	pass
	
func new_coins():
	var area= $Position2D
	var coinsp=coins.instance ()
	get_parent().add_child(coinsp)
	coinsp.position=Vector2((area.global_position.x+50), (area.global_position.y-30))


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="Attack1":
		if $AnimatedSprite.flip_h==true:
			motion.x=-SPEED
		else:
			motion.x=SPEED
		$AnimatedSprite.position.y=-49
		$AnimatedSprite.play("Walk")
	
	

	pass # Replace with function body.


func _on_damage_area_entered(area):
	if area.is_in_group ("hit"):
		print("ZZZZZZZZZZZZZZ")
		lives-=1
	pass # Replace with function body.
