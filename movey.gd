extends CharacterBody2D


const SPEED = 600.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isTimedOut = 0
var i = 1
	
func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	print(JUMP_VELOCITY)
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		isTimedOut = 0
		JUMP_VELOCITY = -400
		i = 1
	if Input.is_action_pressed("charge"):
		#$Timer.start()
		if(i <= 10):
			i += i * delta
			
		else:
			JUMP_VELOCITY = -800
		JUMP_VELOCITY -= i
		print(i)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_timer_timeout():
	isTimedOut = 1
	
