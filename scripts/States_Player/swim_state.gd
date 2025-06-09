extends BaseState

const BOOST: float = -300.0
var speed = 80.0
var jump_velocity= -180.0
var gravity = 0.0

func enter(_prev_state: BaseState) -> void:
	# connecting to detection signal when getting out of water 
	# logic: because player is in swim_state => player is in water => can exit water => can connect on_exit_water
	Signals.on_exit_water.connect(on_water_exit)
	player.main_coll_shape_2d.shape.size.x = player.swim_shape

func exit() -> void:
	Signals.on_exit_water.disconnect(on_water_exit)

func physics_update(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")

	# Movement horizontal & vertical in water
	if direction != 0:
		player.velocity.x = direction * speed
		player.sprite.flip_h = direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.velocity.y = 0
	if Input.is_action_pressed("move_up"):
		player.velocity.y = -speed
	elif Input.is_action_pressed("move_down"):
		player.velocity.y = speed

	# Animation
	player.sprite.play("swim")

func on_water_exit(area : Area2D) -> void:
	if area.is_in_group("player"):
		player.is_in_water = false
		player.velocity.y = BOOST
		player.change_state(player.normal_state)
