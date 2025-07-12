extends Node

var levels = [
	"uid://pdr763i84nx1", # Level 1
	"uid://b1gi27lu2fy3h", # Level 2
	"uid://fbyngqxbwdeh",	# Level 3
	"uid://bbsyght7i03ux", # Scoreboard
	"uid://dlbuqxrtjexbe" # Main Menu
]
var current_level_index: int = 0
var current_level: Node = null

func load_level(index: int, levels_container: Node) -> void:
	var transition = Global.transition
	get_tree().paused = true # Pause all nodes and processes except Transition node in the main game scene. Achieved by setting Transition -> Inspector -> Process -> Mode -> Always 
	await transition.fade_in()
	
	if current_level:
		current_level.queue_free()

	#------------------------------------------------------------------------
	current_level_index = index
	var level_scene = load(levels[index]) #reads the file
	current_level = level_scene.instantiate() #create the scene node in memory
	levels_container.call_deferred("add_child", current_level) #adds the level node to the level container node as a child
	#------------------------------------------------------------------------
	
	get_tree().paused = false
	await transition.fade_out()
	
func reload_current_level(levels_container: Node) -> void:
	load_level(current_level_index, levels_container)

func load_next_level(levels_container: Node) -> void:
	if current_level_index + 1 < levels.size():
		#------------------------------------------
		Global.pineapples_in_level.clear()
		#------------------------------------------
		load_level(current_level_index + 1, levels_container)
	else:
		return
		
func load_end_scene(levels_container: Node) -> void:
	current_level_index = levels.size() - 2
	load_level(current_level_index, levels_container)

func clear_levels(levels_container: Node) -> void:
	#var transition = Global.transition
	#await transition.fade_in()
	
	for child in levels_container.get_children():
		child.queue_free()
	current_level = null
	
	#await transition.fade_out()
