extends Node

var levels = [
	"uid://pdr763i84nx1",
	"uid://b1gi27lu2fy3h",
	"uid://fbyngqxbwdeh"
]
var current_level_index: int = 0
var current_level: Node = null

func load_level(index: int, levels_container: Node) -> void:
	if current_level:
		current_level.queue_free()
		
	var transition = get_tree().root.get_node("Main_Game/Transition")
	var gui = get_tree().root.get_node("Main_Game/GUI")
	gui.visible = false
	await transition.fade_in()
	
	#------------------------------------------------------------------------
	current_level_index = index
	var level_scene = load(levels[index]) #reads the file
	current_level = level_scene.instantiate() #create the scene node in memory
	levels_container.call_deferred("add_child", current_level) #adds the level node to the level container node as a child
	#------------------------------------------------------------------------
	
	gui.visible = true
	transition.fade_out()
	
func reload_current_level(levels_container: Node) -> void:
	load_level(current_level_index, levels_container)

func load_next_level(levels_container: Node) -> void:
	if current_level_index + 1 < levels.size():
		load_level(current_level_index + 1, levels_container)
	else:
		print("no levels")
