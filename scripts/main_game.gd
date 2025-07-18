extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set a global reference of the 'Levels' node in 'Main_Game' scence on game start-up.
	Global.set_levels_reference($Levels)
	Global.set_transition_reference($Transition)
	SoundPlayer.play_music(preload("uid://3tssepmr1yd3"))
