extends StaticBody2D

const KNOCKBACK_POWER = 220.0

@onready var saw: RigidBody2D = $saw
@onready var pin_joint: PinJoint2D = $PinJoint2D
@onready var line_2d: Line2D = $Line2D
var velocity := 9


func _ready():
	pin_joint.motor_enabled = true
	pin_joint.motor_target_velocity = velocity

func _process(_delta: float) -> void:
	line_2d.points = [Vector2.ZERO, saw.position]
func _physics_process(_delta):
	#line_2d.points = [Vector2.ZERO, saw.position]
	if abs(saw.angular_velocity) < 0.1:
		velocity *= -1
		pin_joint.motor_target_velocity =  velocity
		line_2d.points = [Vector2.ZERO, saw.position]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Signals.on_hit.emit(saw.global_position, KNOCKBACK_POWER) 
