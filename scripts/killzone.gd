extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	Global.life -= 1
	if(Global.life <= 0):
		get_tree().reload_current_scene()
		Global.life = 3
		Global.picked_pineapples = 0
	timer.start()

func _on_timer_timeout() -> void:
	var spawn_point = get_parent().get_node("start_spawn")
	var player = get_parent().get_node("Player")
	Global.position = spawn_point.global_position
	player.global_position = Global.position
	
