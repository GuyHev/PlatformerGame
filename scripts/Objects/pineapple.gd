extends Area2D

var key;

func _ready() -> void:
	key = str(global_position)
	if Global.pineapples_in_level.has(key):
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	if not Global.pineapples_in_level.has(key):
		SoundPlayer.play_sfx(preload("uid://bpgpfoafrfmfk"))
		Global.pineapples_in_level[key] = true
		Global.pineapples_left -= 1
		Global.pineapples_collected += 1
		Global.score += Global.difficulty[Global.difficulty_index].pineapple_score
	queue_free()
