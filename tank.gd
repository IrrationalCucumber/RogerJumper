extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var screen_size

func _physics_process(delta):
	#screen 
	#screen_size = get_viewport_rect().size
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
 
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
# Enable animation
	if (velocity.x != 0  or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and is_on_floor():
		$AnimatedSprite2D.play("run")
	elif velocity.y !=0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.stop() 
	else:
		$AnimatedSprite2D.play("idle")
# resitric to screen size
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	#flip sprite on direction
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	#jump
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
