extends StaticBody2D

const KNOCKBACK_POWER = 220.0

@onready var saw: RigidBody2D = $saw
@onready var pin_joint: PinJoint2D = $PinJoint2D
var velocity := 9

func _ready():
	pin_joint.motor_enabled = true
	pin_joint.motor_target_velocity = velocity

func _physics_process(delta):
	if abs(saw.angular_velocity) < 0.1:
		velocity *= -1
		pin_joint.motor_target_velocity =  velocity

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.life -= 1
		Signals.on_hit.emit(saw.global_position, KNOCKBACK_POWER) 
