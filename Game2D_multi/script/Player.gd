extends KinematicBody2D
 
const UP = Vector2(0, -1)
const ACC = 50
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT =  -680
var motion = Vector2()

signal player_spacebar

var interative_object=null


var attack=false
var health : int = 100

onready var animationPlayer = $AnimatedSprite

func _physics_process(delta): 
	
	motion.y += GRAVITY
	
	if Global.count_lives<=0:
		$AnimatedSprite.play("Death")
	else:
		
		if Input.is_action_pressed("Attack_R"):
			$hit_R/CollisionShape2D.disabled=false
			animationPlayer.flip_h=false
			$AnimatedSprite.play("Attack")
			motion.x = min(motion.x + ACC, SPEED)
			print("A")
			attack=true
			
		elif Input.is_action_pressed("Attack_L"):
			$hit_L/CollisionShape2D.disabled=false
			animationPlayer.play("Attack")
			animationPlayer.flip_h=true
			print("B")
			attack=true
			
		
		elif Input.is_action_pressed("ui_right") && attack==false:
			animationPlayer.flip_h = false
			animationPlayer.play("Run")
			motion.x = min(motion.x + ACC, SPEED)
			
		elif Input.get_action_strength("ui_left") && attack==false:
			animationPlayer.flip_h = true
			animationPlayer.play("Run")
			motion.x = max(motion.x - ACC, -SPEED)
			
		elif Input.is_action_pressed("ui_accept"):
			emit_signal("player_spacebar", interative_object)
			
		else:
			if attack==false:
				animationPlayer.play("Idle")
				$hit_R/CollisionShape2D.disabled=true 
				$hit_L/CollisionShape2D.disabled=true 
			motion.x = lerp(motion.x, 0, 0.2)

		if is_on_floor() && attack==false: 
			if Input.is_action_just_pressed("ui_up"):
				jump()
		else:
			if attack==false:
				animationPlayer.play(" Jump")
				$hit_R/CollisionShape2D.disabled=true

		motion = move_and_slide(motion, UP)

func jump():
	motion.y = JUMP_HEIGHT
	
func damage_player (damage):
	health -=damage
	

func _on_AnimatedSprite_animation_finished():
	if animationPlayer.animation=="Attack":
		yield(get_tree().create_timer(0.5),"timeout")
		attack=false
	
	if $AnimatedSprite.animation =="Death":
		yield(get_tree().create_timer(0.5),"timeout")
		queue_free ()
		get_tree().change_scene("res://Scena/GameOver.tscn")
	


func _on_damage_area_entered(area):
	if area.is_in_group ("hit_s"):
		Global.count_lives-=2
		$damage/CollisionShape2D2.disabled=true
		yield(get_tree().create_timer(0.4),"timeout")
		$damage/CollisionShape2D2.disabled=false



func _on_Area2D_area_entered(area):
	if area.is_in_group("interative_object"):
		interative_object=area


func _on_Area2D_area_exited(area):
	if area.is_in_group("interative_object"):
		interative_object=null
