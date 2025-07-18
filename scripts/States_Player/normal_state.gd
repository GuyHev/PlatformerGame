extends BaseState

var speed = 130.0
var jump_velocity= -300.0
var gravity = 900.0

func enter(_prev_state: BaseState) -> void:
	player.main_coll_shape_2d.shape.size.x = player.normal_shape

func exit() -> void:
	pass
	
func physics_update(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")

	# Movement horizontal
	if direction != 0:
		player.velocity.x = direction * speed
		player.sprite.flip_h = direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	# Apply gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		SoundPlayer.play_sfx(preload("uid://b1iklcb84i3dq"))
		player.velocity.y = jump_velocity

	# Animation
	if not player.is_on_floor():
		if player.velocity.y < 0:
			player.sprite.play("jump")
		else:
			player.sprite.play("fall")
	elif direction != 0:
		player.sprite.play("run")
	else:
		player.sprite.play("idle")
