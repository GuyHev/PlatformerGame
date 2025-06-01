extends CharacterBody2D 

@onready var sprite = $AnimatedSprite2D
@onready var main_coll_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area2d_coll_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

# States
var normal_state
var swim_state
var knockback_state
var dead_state

#Player variables
var is_in_water = false
var normal_shape
var swim_shape
var current_state: Node = null

func _ready() -> void:
	# Connect Signals
	Signals.on_hit.connect(apply_knockback)
	
	# Initialize shapes
	normal_shape = main_coll_shape_2d.shape.size.x
	swim_shape = area2d_coll_shape_2d.shape.size.x

	# Load states and assign player reference
	normal_state = preload("uid://sndnetw7olwx").new()
	swim_state = preload("uid://bej3f48imahls").new()
	knockback_state = preload("uid://c6gmcsh85n4m2").new()
	dead_state = preload("uid://c6kpkvlv72m3q").new()

	for state in [normal_state, swim_state, knockback_state, dead_state]:
		add_child(state)
		state.player = self

	change_state(normal_state)

func _physics_process(delta: float) -> void:
	if Global.life <= 0:
		current_state = dead_state
		change_state(current_state)
	else:
		current_state.physics_update(delta)
		move_and_slide()

func change_state(new_state: BaseState) -> void:
	if current_state != null:
		current_state.exit()
	var prev_state = current_state
	current_state = new_state
	current_state.enter(prev_state)

func apply_knockback(from_position: Vector2 = Vector2.ZERO, strength: float = 200.0) -> void:
	knockback_state.setup(from_position, strength)
	change_state(knockback_state)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("water"):
		is_in_water = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("water"):
		is_in_water = false
		velocity.y = -300
