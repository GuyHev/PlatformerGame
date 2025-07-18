extends Button

@onready var confirmation_dialog: ConfirmationDialog = $"../ConfirmationDialog"
@onready var label: Label = $Label


func _ready() -> void:
	pass # Replace with function body.

func _on_button_down() -> void:
	label.global_position += Vector2(0,2)

func _on_button_up() -> void:
	label.global_position += Vector2(0,-2)

func _on_pressed() -> void:
	SoundPlayer.play_sfx(preload("uid://6f5s0t2k7h2u"))
	confirmation_dialog.visible = true
