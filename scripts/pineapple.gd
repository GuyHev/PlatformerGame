extends Area2D


func _on_body_entered(_body: Node2D) -> void:	
	add_pineapple()
	queue_free()
func add_pineapple() -> void:
	Global.picked_pineapples +=1
