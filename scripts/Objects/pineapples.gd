extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.pineapples_left = get_child_count()
