extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
const SPEED = 100
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
	#var distance_moved = global_position.x - start_position.x
	#if abs(distance_moved) >= patrol_distance:
		#direction *= -1
		#if $Sprite2D:  # flip sprite when turning
		#	$Sprite2D.flip_h = direction < 0
	move_and_slide()
func _on_area_2d_body_entered(_body: Node2D) -> void:
	Global.life -= 1
	Signals.on_hit.emit(global_position, 200.0)
	if(Global.life <= 0):
		get_tree().reload_current_scene()
		Global.life = 3
		Global.picked_pineapples = 0
