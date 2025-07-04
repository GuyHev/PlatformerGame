extends Button

@onready var label: Label = $Label

func _on_pressed() -> void:
	# Load first level
	Global.set_life()
	LevelManager.load_level(0, Global.levels)
	await get_tree().create_timer(1.0).timeout
	get_tree().root.get_node("Main_Game/Main_Menu").queue_free()
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
