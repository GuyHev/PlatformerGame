extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
const SPEED = 100
const KNOCKBACK_POWER = 200.0
var start_position: Vector2
var direction: int = 1  # 1 = right, -1 = left

func _ready() -> void:
	start_position = global_position
func _physics_process(_delta: float) -> void:
	velocity.x = SPEED * direction
	if not ray_cast_2d.is_colliding():
		direction *= -1
		ray_cast_2d.position.x *= -1
		animated_sprite_2d.flip_h = direction < 0
	move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Signals.on_hit.emit(global_position, KNOCKBACK_POWER)
