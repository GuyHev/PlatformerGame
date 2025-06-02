extends BaseState

const KNOCKBACK_DURATION = 0.4

var timer = 0.0
var knockback_velocity = Vector2.ZERO

func enter(_prev_state: BaseState) -> void:
	timer = KNOCKBACK_DURATION
	player.sprite.play("hit")

func physics_update(delta: float) -> void:
	timer -= delta
	player.velocity = knockback_velocity

	if timer <= 0:
		if player.is_in_water:
			player.change_state(player.swim_state)
		else:
			player.change_state(player.normal_state)

func _ready() -> void:
	# The object that hitting responsible to emit singal, thus this state only need to connect when we preloaded and added as node
	Signals.on_hit.connect(setup)
	
func setup(from_position: Vector2, strength: float) -> void:
	knockback_velocity = (player.global_position - from_position).normalized() * strength
	player.change_state(player.damaged_state)
