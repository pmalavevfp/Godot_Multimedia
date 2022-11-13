extends KinematicBody2D
 
const ACCELERATION = 70
const MAX_SPEED = 300
const JUMP_H = -900
const UP = Vector2(0, -1)
const gravity = 40
 
onready var sprite = $AnimatedSprite
onready var animationPlayer = $AnimatedSprite
 
var motion = Vector2()
 
func _physics_process(delta):
	# apply gravity to the player
	motion.y += gravity
	var friction = false
 
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("Run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("Run")
		sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("ui_up"):
		animationPlayer.play("Run")
		sprite.flip_h = true
		motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
	else:
		animationPlayer.play("Idle")
		friction = true
 
	if is_on_floor():
 
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
 
	
