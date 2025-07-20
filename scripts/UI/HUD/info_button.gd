extends Button

@onready var label: Label = $Label
#@onready var accept_dialog: AcceptDialog = $"../AcceptDialog"
@onready var accept_dialog: AcceptDialog = $AcceptDialog


func _on_pressed() -> void:
	SoundPlayer.play_sfx(preload("uid://6f5s0t2k7h2u"))
	accept_dialog.visible = true
	
func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)
