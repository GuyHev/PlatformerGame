extends BaseState

var speed = 80.0
var jump_velocity= -180.0
var gravity = 0.0

func enter(_prev_state: BaseState) -> void:
	player.main_coll_shape_2d.shape.size.x = player.swim_shape

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

	# Transition back to NormalState if out of water
	if not player.is_in_water:
		player.velocity.y = jump_velocity
		player.change_state(player.normal_state)
