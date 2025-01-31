extends CharacterBody2D

class_name Slime
const SPEED = 300.0
var JUMP_VELOCITY = -1000.0
var health = 100
var clone_speed_1 = 100
var clone_speed_2 = -100
var flag2 = 0
@onready var healthbar = $"../Healthbar2"
@onready var animationplayer = $AnimationPlayer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flag = 1
var timerOver = 0

func _ready():
	healthbar.value = health
	
func _physics_process(delta):
	# Add the gravity.
	var node = get_node_or_null("../slimeers")
	healthbar.value = health
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		animationplayer.play("jump")
		velocity.y = JUMP_VELOCITY
	if health <= 0:
		Global.isSlimeDead = 1
		queue_free()
			
			
		
		
		
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

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration, true, false, true).timeout)
	Engine.time_scale = 1






func _on_timer_2_timeout():
	timerOver = 1
	
