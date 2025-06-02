extends Node

var levels = [
	"uid://pdr763i84nx1",
	"uid://b1gi27lu2fy3h",
	"uid://fbyngqxbwdeh"
]

var current_level_index = 0

func load_current_level(main_scene: Node):
	var container = main_scene.get_node("Levels")

	# Clear old level
	for child in container.get_children():
		child.queue_free()
	
	# Load and add new level
	var scene = load(levels[current_level_index]) as PackedScene
	var level = scene.instantiate()
	container.add_child(level)

func load_next_level(main_scene: Node):
	current_level_index += 1
	if current_level_index < levels.size():
		load_current_level(main_scene)
	else:
		print("No more levels")
