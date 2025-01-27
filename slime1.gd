extends CharacterBody2D

class_name Slime
const SPEED = 300.0
const JUMP_VELOCITY = -1000.0
var health = 100

@onready var healthbar = $Healthbar
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag = 1

func _ready():
	healthbar.value = health
	
func _physics_process(delta):
	# Add the gravity.
	healthbar.value = health
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	if health <= 0:
		delete_self()
	move_and_slide()


func _on_cooltimer_timeout():
	if(flag == 1):
		velocity.x = -SPEED
		flag = -flag
	else:
		velocity.x = SPEED
		flag = -flag
		
func delete_self():
	queue_free()  # Removes the current node


func _on_area_2d_body_entered(body):
	if body is Player:
		body.playerHealth -= 50
		print("lessgo")
