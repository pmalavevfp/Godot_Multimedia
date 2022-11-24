extends KinematicBody2D
 
const ACCELERATION = 70
const MAX_SPEED = 300
const UP = Vector2(0, -1)
const gravity = 40
 
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
 
var motion = Vector2()
 
func _physics_process(delta):
	motion.y += gravity
	var friction = false
 
	if Input.is_action_pressed("ui_right"):
		#sprite.flip_h = true
		animationPlayer.play("Sprite_run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("Sprite_run")
		#sprite.flip_h = false
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		animationPlayer.play("Sprite_Idle")
		friction = true
 
