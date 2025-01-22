extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag = 1

func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()


func _on_cooltimer_timeout():
	if(flag == 1):
		velocity.x = -SPEED
		flag = -flag
	else:
		velocity.x = SPEED
		flag = -flag
