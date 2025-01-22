extends CharacterBody2D


const SPEED = 600.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isTimedOut = 0
var i = 1
var isAttackPhase = 0
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and isAttackPhase == 0:
		velocity.y = JUMP_VELOCITY
		JUMP_VELOCITY = -400
		i = 1
	if Input.is_action_just_pressed("attack") and isAttackPhase == 1:
		velocity.x = SPEED * 10
		$Timer.start()
		
			
		
	if Input.is_action_pressed("charge") and isAttackPhase == 0:
		#$Timer.start()
		if(i <= 10):
			i += i * delta
			
		else:
			JUMP_VELOCITY = -800
		JUMP_VELOCITY -= i
	
		
	if Input.is_action_just_pressed("attack_phase") and isAttackPhase == 0:
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
	velocity.x = -SPEED * 10
	isTimedOut = 0
	print("hmmm")
	
