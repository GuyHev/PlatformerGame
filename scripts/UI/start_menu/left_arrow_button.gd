extends Button

@onready var label: Label = $Label
@onready var difficulty: Label = $"../difficulty"

func _on_pressed() -> void:
	Global.select_difficulty(0)
	difficulty.text = Global.difficulty[Global.difficulty_index].name
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
