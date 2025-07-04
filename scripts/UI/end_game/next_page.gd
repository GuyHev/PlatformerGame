extends Button

@onready var label: Label = $Label

func _on_pressed() -> void:
	pass
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
