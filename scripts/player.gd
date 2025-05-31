extends CharacterBody2D 

const KNOCKBACK_DURATION = 0.4

@onready var sprite = $AnimatedSprite2D
@onready var main_coll_shape_2d:  = $CollisionShape2D
@onready var area2d_coll_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var profiles = {
	"normal": {"speed": 130.0, "jump_velocity": -300.0,"gravity": 900.0, "shape_w": Shape2D},
	"water": {"speed": 80.0, "jump_velocity": -180.0,"gravity": 0.0, "shape_w": Shape2D}
}
var current_profile = "normal"
var is_in_water = false
# Physics values
var speed = 130.0
var jump_velocity = -300.0
var gravity = 900

var knockback_velocity := Vector2.ZERO
var knockback_timer := 0.0

func _ready() -> void:
	Signals.on_hit.connect(self.knockback)
	store_shape(main_coll_shape_2d,"normal")
	store_shape(area2d_coll_shape_2d,"water")

func _physics_process(delta: float) -> void:
	if is_dead():
		die()
	else:
		if knockback_timer > 0:
			knockback_timer -= delta
			velocity = knockback_velocity
		else:
			var direction := Input.get_axis("move_left", "move_right")
			current_profile = "water" if is_in_water else "normal"
			# Load values from dictionary
			var value_set = profiles[current_profile]
			speed = value_set["speed"]
			jump_velocity = value_set["jump_velocity"]
			gravity = value_set["gravity"]
			handle_physics(delta, direction)
			handle_animation(direction)
		move_and_slide()

func handle_physics(delta: float, direction: float) -> void:
	if current_profile == "water":
		#set main collision shape for water detection
		main_coll_shape_2d.shape.size.x = (profiles["water"])["shape_w"]
		
		if direction != 0:
			velocity.x = direction * speed
			sprite.flip_h = direction < 0 #the right part afte '=' return boolean expression
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = 0.0
		if Input.is_action_pressed("move_up"):
			velocity.y = -speed
		elif Input.is_action_pressed("move_down"):
			velocity.y = speed
		velocity.x = direction * speed
	if current_profile == "normal":
		#set main collision shape for normal detection
		main_coll_shape_2d.shape.size.x = (profiles["normal"])["shape_w"]
		
		# Apply gravity
		if not is_on_floor():
			velocity.y += gravity * delta	
			
		# Handle jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
			
		# Horizontal input
		if direction != 0:
			velocity.x = direction * speed
			sprite.flip_h = direction < 0 #the right part afte '=' return boolean expression
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

func handle_animation(direction: float) -> void:
	if current_profile == "water":
		sprite.play("swim")
	else:
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("water"):
		is_in_water = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("water"):
			is_in_water = false
			velocity.y = (profiles["normal"])["jump_velocity"]

func store_shape(collision2d: CollisionShape2D, profile: String):
	(profiles[profile])["shape_w"] = collision2d.shape.size.x
	
