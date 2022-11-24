extends KinematicBody2D


export (int) var damage = 20

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 40

var flag=0
var turn_around=false

var heart =preload ("res://Scena/gain_lives.tscn")

var lives=7



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
		yield(get_tree().create_timer(1.0),"timeout")
		queue_free()
		new_coins()
		
		
	elif $Att_R_ray.is_colliding():
		if $AnimatedSprite.flip_h==true:
			_flip()
			motion.x=0
		$Hit_R/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-87
		$AnimatedSprite.position.x=45
		$AnimatedSprite.play("Attack2")
		yield(get_tree().create_timer(0.9),"timeout")
		$Hit_R/CollisionShape2D.disabled=true
		
	elif $Att_L_ray.is_colliding():
	
		if $AnimatedSprite.flip_h==false:
			_flip()
			motion.x=0
		$Hit_L/CollisionShape2D.disabled=false
		$AnimatedSprite.position.y=-87
		$AnimatedSprite.position.x=15
		$AnimatedSprite.play("Attack2")
		yield(get_tree().create_timer(0.9),"timeout")
		$Hit_L/CollisionShape2D.disabled=true
	
func _next_to_left_wall()->bool:
	return $Left_Ray.is_colliding()
	
func _next_to_right_wall()->bool:
	return $Right_Ray.is_colliding()
	
func _floor_detection_L ()->bool:
	return $CollisionShape2D/Floor_Detection_L.is_colliding()
	
func _floor_detection_R ()->bool:
	return $CollisionShape2D/Floor_Detection_D.is_colliding()
	
	
func _flip():
	motion.x *= -1
	if $AnimatedSprite.flip_h==true:
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true

func _move():
	if _next_to_left_wall() or _next_to_right_wall() or!_floor_detection_L () or !_floor_detection_R():
		_flip()
		
func hit ():
	pass
	
func new_coins():
	var area= $Position2D
	var heartp=heart.instance ()
	get_parent().add_child(heartp)
	heartp.position=Vector2((area.global_position.x+50), (area.global_position.y-30))


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="Attack2":
		if $AnimatedSprite.flip_h==true:
			motion.x=-SPEED
		else:
			motion.x=SPEED
		$AnimatedSprite.position.y=-55
		$AnimatedSprite.position.x=24
		$AnimatedSprite.play("Walk")



func _on_damage_area_entered(area):
	if area.is_in_group ("hit"):
		lives-=1
