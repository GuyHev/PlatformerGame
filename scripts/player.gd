extends CharacterBody2D 


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 900
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	handle_physics(delta,direction)
	handle_animation(direction)
	move_and_slide()
func handle_physics(delta: float, direction: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta	
		
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Horizontal input
	if direction != 0:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0 #the right part afte '=' return boolean expression
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
func handle_animation(direction: float) -> void:
	#check if player in air
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")  # Going up
		else:
			sprite.play("fall")  # Coming down
	#check if player in not standing still
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")
func bounce(force: float) -> void:
	velocity.y = force
