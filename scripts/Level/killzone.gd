extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.life -= 1
		if(Global.life <= 0):
			Global.deaths += 1
			Global.set_life()
		LevelManager.reload_current_level(Global.levels)
		timer.start()

func _on_timer_timeout() -> void:
	var spawn_point = get_parent().get_node("start_spawn")
	var player = get_parent().get_node("Player")
	player.global_position = spawn_point.global_position
	
