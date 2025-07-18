extends AcceptDialog



func _on_confirmed() -> void:
	SoundPlayer.play_sfx(preload("uid://6f5s0t2k7h2u"))


func _on_canceled() -> void:
	SoundPlayer.play_sfx(preload("uid://6f5s0t2k7h2u"))
