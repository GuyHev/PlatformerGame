extends Button

@onready var label: Label = $Label

func _on_pressed() -> void:
	var transition = Global.transition
	await transition.fade_in()
	LevelManager.clear_levels(Global.levels)
	get_tree().root.get_node("Main_Game/Main_Menu").visible = true
	await transition.fade_out()
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
