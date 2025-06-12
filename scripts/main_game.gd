extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.load_current_level(self)
