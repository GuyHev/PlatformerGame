extends Node2D

@onready var player = $Player
@onready var spawn_point = $start_spawn
@onready var killzone = $Killzone  # Adjust if path is different

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.position = spawn_point.global_position
	player.global_position = Global.position

func _on_player_died():
	Global.position = spawn_point.global_position
	player.global_position = Global.position
	
