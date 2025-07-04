extends Area2D

var key;

func _ready() -> void:
	key = str(global_position)
	if Global.collected_pineapples.has(key):
		queue_free()

func _on_body_entered(_body: Node2D) -> void:	
	if not Global.collected_pineapples.has(key):
		Global.collected_pineapples[key] = true
		Global.pineapples_left -= 1
		Global.score += Global.difficulty[Global.difficulty_index].pineapple_score
	queue_free()
