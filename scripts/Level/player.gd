extends CharacterBody2D 

@onready var sprite = $AnimatedSprite2D
@onready var main_coll_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area2d_coll_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var dust_particle_run: GPUParticles2D = $dust_particle_run
@onready var dust_particle_land: GPUParticles2D = $dust_particle_land
@onready var camera_2d: Camera2D = $Camera2D

# States
var normal_state
var swim_state
var damaged_state
var dead_state

# Player variables
var is_in_water = false
var normal_shape
var swim_shape
var current_state: Node = null
var was_on_floor = false

func _ready() -> void:
	"""
		Note: 
		1. This game is jittering. This happens in most pixel art games.
		2. To prevent jittering we enable Physics interpolation in the project settings.
		3. When loading new level, due to Physics interpolation being enabled the player camera becomes inactive.
		4. We use the line below to fix this.
	"""
	camera_2d.make_current()
	
	# Initialize shapes
	normal_shape = main_coll_shape_2d.shape.size.x
	swim_shape = area2d_coll_shape_2d.shape.size.x

	# Load states and assign player reference
	normal_state = preload("uid://sndnetw7olwx").new()
	swim_state = preload("uid://bej3f48imahls").new()
	damaged_state = preload("uid://c6gmcsh85n4m2").new()
	dead_state = preload("uid://c6kpkvlv72m3q").new()
	
	# Add states files as nodes of Player
	for state in [normal_state, swim_state, damaged_state, dead_state]:
		add_child(state)
		state.player = self

	change_state(normal_state)

func _physics_process(delta: float) -> void:
	apply_dust()
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

func apply_dust():
	if not was_on_floor and is_on_floor():
		dust_particle_land.restart()
	was_on_floor = is_on_floor()
	
	if velocity.x != 0 and is_on_floor() :
		var direction = sign(velocity.x)
		dust_particle_run.process_material.direction = Vector3(direction, 0, 0)
		var offset = 10 * -direction
		dust_particle_run.process_material.emission_shape_offset = Vector3(offset, 0, 0)
		dust_particle_run.emitting = true
	else: 
		dust_particle_run.emitting = false
