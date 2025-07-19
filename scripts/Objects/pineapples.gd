extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var counter = 0
	for pineapple in  Global.pineapples_in_level:
		if pineapple:
			counter += 1
	Global.pineapples_left = get_child_count() - counter
