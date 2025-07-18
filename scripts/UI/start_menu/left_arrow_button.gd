extends Button

@onready var label: Label = $Label
@onready var difficulty: Label = $"../difficulty"

func _on_pressed() -> void:
	SoundPlayer.play_sfx(preload("uid://cwc71poi53v2i"))
	Global.select_difficulty(0)
	difficulty.text = Global.difficulty[Global.difficulty_index].name
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
