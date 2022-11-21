extends KinematicBody2D

export (int) var damage = 20

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 40

var motion = Vector2()

func _ready():
	$AnimatedSprite.scale.x = 1
	motion.x = SPEED
	
func _physics_process(_delta):
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





