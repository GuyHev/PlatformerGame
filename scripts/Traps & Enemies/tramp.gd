extends Area2D

const BOUNCE_VELOCITY = -500

@onready var sprite = $AnimatedSprite2D
var is_bouncing = false  # New flag to track if the player has bounced yet

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and (not is_bouncing):
		if body.velocity.y >= 0:
			body.velocity.y = BOUNCE_VELOCITY
			sprite.play("on jump")
			is_bouncing = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_bouncing = false
