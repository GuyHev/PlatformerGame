extends CharacterBody2D 


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 900
const KNOCKBACK_DURATION = 0.4

@onready var sprite = $AnimatedSprite2D

var knockback_velocity := Vector2.ZERO
var knockback_timer := 0.0

func _ready() -> void:
	Signals.on_hit.connect(self.knockback)
func _physics_process(delta: float) -> void:
	if not is_dead():
		if not((Global.life <= 0)):
			pass
		if knockback_timer > 0:
			knockback_timer -= delta
			velocity = knockback_velocity
		else:
			var direction := Input.get_axis("move_left", "move_right")
			handle_physics(delta, direction)
			handle_animation(direction)
		move_and_slide()
	else:
		die()
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
func knockback(from_position: Vector2 = global_position, strength: float = 200.0) -> void:
	var direction = (global_position - from_position).normalized()
	knockback_velocity = direction * strength
	knockback_timer = KNOCKBACK_DURATION
	sprite.play("hit")
func die() -> void:
	get_tree().reload_current_scene()
	Global.life = 3
	Global.picked_pineapples = 0
func is_dead() -> bool:
	if	(Global.life <= 0):
		return	true
	return false		
