extends CharacterBody2D

class_name Slime
const SPEED = 300.0
var JUMP_VELOCITY = -1000.0
var health = 50


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
		var copy1 = duplicate()
		var copy2 = duplicate()
		copy1.scale = Vector2(2, 2)
		copy2.scale = Vector2(2, 2)
		copy1.JUMP_VELOCITY = -500
		copy2.JUMP_VELOCITY = -500
		copy2.global_position = global_position + Vector2(10, 10)
		copy1.global_position = copy2.global_position + Vector2(70 , -80)
		$"../slimeers".add_child(copy1)
		$"../slimeers".add_child(copy2)
		
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
