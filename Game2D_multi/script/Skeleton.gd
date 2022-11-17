extends KinematicBody2D

export (int) var damage = 20

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 40

var lives=0

var motion = Vector2()

func _ready():
	$AnimatedSprite.scale.x = 1
	motion.x = SPEED
	
func _process(_delta):
	hit()
	
func _physics_process(_delta):
	
	if lives <=0:
		$AnimatedSprite.play("Death")
	
	motion.y += GRAVITY
	_move()

	motion = move_and_slide(motion)
	

	
func _next_to_left_wall()->bool:
	
	#print ("l" +str($Left_Ray.is_colliding()))
	return $Left_Ray.is_colliding()
	
func _next_to_right_wall()->bool:
	
	
	#print (str($Right_Ray.is_colliding()))
	return $Right_Ray.is_colliding()
	
func _floor_detection ()->bool:
	#print ("FF"+str($AnimatedSprite/Floor_Detection.is_colliding()))
	return $AnimatedSprite/Floor_Detection.is_colliding()
	

func _flip():
	motion.x *= -1
	$AnimatedSprite.scale.x *= -1

func _move():
	if _next_to_right_wall() or _next_to_left_wall() or !_floor_detection():
		_flip()

func hit ():
	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.play("Death"):
		queue_free()
	pass # Replace with function body.



func _on_damage_body_entered(body):
	if body.is_in_group ("hit"):
		lives -=1
	pass # Replace with function body.
