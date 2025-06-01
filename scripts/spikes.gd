extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	Global.life -= 1
	Signals.on_hit.emit(global_position, 50)
