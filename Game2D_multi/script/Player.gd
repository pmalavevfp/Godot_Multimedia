extends KinematicBody2D
 
const UP = Vector2(0, -1)
const ACC = 50
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT =  -650
var motion = Vector2()

var health : int = 100

onready var animationPlayer = $AnimatedSprite

func _physics_process(delta): 
	
	if Global.count_lives<=0:
		$animatedSprite.Death
	else:
		motion.y += GRAVITY

		if Input.is_action_pressed("ui_right"):
			animationPlayer.flip_h = false
			animationPlayer.play("Run")
			motion.x = min(motion.x + ACC, SPEED)
		elif he_goes_left():
			animationPlayer.flip_h = true
			animationPlayer.play("Run")
			motion.x = max(motion.x - ACC, -SPEED)
		else:
			animationPlayer.play("Idle") 
			motion.x = lerp(motion.x, 0, 0.2)

		if is_on_floor(): 
			if Input.is_action_just_pressed("ui_up"):
				jump()
		else:
			animationPlayer.play(" Jump")

		motion = move_and_slide(motion, UP)

func he_goes_right():
	return Input.get_action_strength("ui_right")

func he_goes_left():
	return Input.get_action_strength("ui_left")

func jump():
	motion.y = JUMP_HEIGHT
	
func damage_player (damage):
	health -=damage
	

 


func _on_AnimatedSprite_animation_finished():
	#if $AnimatedSprite.animation == "Death"
		#queue_free ()
	pass
