extends Button

@onready var label: Label = $Label

func _on_pressed() -> void:
	# Load first level
	Global.set_life()
	Global.score = 0
	Global.deaths = 0
	LevelManager.load_level(0, Global.levels)
	await get_tree().create_timer(1.0).timeout
	get_tree().root.get_node("Main_Game/Main_Menu").visible = false
	get_tree().root.get_node("Main_Game/GUI").visible = true
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
