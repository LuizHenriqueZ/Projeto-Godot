extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#VARIÁVEL BOOLEANA, OU SEJA TRUE OU FALSE 
var is_jumping := false
#PAlAVRA RESERVADA ONREADY
@onready var animation := $Animacao as AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor:
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction 
		#caso não esteja pulando 
		if !is_jumping: #if is_not jumping
			animation.play("run")
			#caso pular 
		elif is_jumping: #is_jumpping == true 
			animation.play("jump")
	else:
		animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
