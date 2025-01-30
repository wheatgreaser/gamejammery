extends CharacterBody2D

class_name Player
const SPEED = 600.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isTimedOut = 0
var i = 1
var isAttackPhase = 0
var playerHealth = 100
var tempplayerhealth = 100
@onready var healthbar = $Healthbar
var isFlashOver = 1

func _ready():
	healthbar.value = playerHealth

func _physics_process(delta):
	
	healthbar.value = playerHealth
	if playerHealth <= 0:
		get_tree().change_scene_to_file("res://youdied.tscn")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.x > 0:
		$AnimationPlayer.play("rolling")
	if velocity.x < 0:
		$AnimationPlayer.play("rolling_reverse")
	if velocity.x == 0:
		$AnimationPlayer.play("idle")
	if Input.is_action_just_pressed("jump") and is_on_floor() and isAttackPhase == 0:
		velocity.y = JUMP_VELOCITY
		JUMP_VELOCITY = -400
		i = 1
	if Input.is_action_just_pressed("attack") and isAttackPhase == 1:
		
		$Camera2D.apply_shake()
		velocity.x = SPEED * 10
		
		
		$Timer.start()
	if(playerHealth < tempplayerhealth ):
		if(isFlashOver == 1):
			$sprite.material.set_shader_parameter("flash_modifier", 0.5)
			$Timer2.start()
			isFlashOver = 1
		tempplayerhealth = playerHealth
	if(isFlashOver == 0):

		$sprite.material.set_shader_parameter("flash_modifier", 0)
		
		
	if $Camera2D.shake_strength > 0:
			$Camera2D.shake_strength = lerpf($Camera2D.shake_strength,0,$Camera2D.shakeFade * delta)
			$Camera2D.offset = $Camera2D.randomOffset()	
			
	
	if Input.is_action_pressed("charge") and isAttackPhase == 0:
		#$Timer.start()
		
		
		if(i <= 10):
			i += i * delta
			
		else:
			JUMP_VELOCITY = -800
		JUMP_VELOCITY -= i
	
		
	if Input.is_action_just_pressed("attack_phase") and isAttackPhase == 0:
		velocity.y = 10000
	
		
		isAttackPhase = 1
	elif Input.is_action_just_pressed("attack_phase") and isAttackPhase == 1:
		isAttackPhase = 0
	
	var direction = Input.get_axis("left", "right")
	if direction and isAttackPhase == 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_timer_timeout():
	isTimedOut = 1
	velocity.x = -SPEED * 12
	isTimedOut = 0

func _on_area_2d_body_entered(body):
	if body is Slime && isAttackPhase == 1:
		$impactplay.play()
		if body.health > 30:
			frameFreeze(0.05, 0.5)
		body.health -= 20
		print(body.health)
	if body is Slime1 && isAttackPhase == 1:
		$impactplay.play()
		if body.health > 30:
			frameFreeze(0.05, 0.5)
		
		body.health -= 20
		print(body.health)
	if body is Slime2 && isAttackPhase == 1:
		$impactplay.play()
		if body.health > 30:
			frameFreeze(0.05, 0.5)
		
		body.health -= 20
		print(body.health)
		
func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		Engine.time_scale = 1
func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration, true, false, true).timeout)
	Engine.time_scale = 1	


func _on_timer_2_timeout():
	isFlashOver = 0
