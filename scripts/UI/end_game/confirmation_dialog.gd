extends ConfirmationDialog

@onready var line_edit: LineEdit = $LineEdit

var submitted = false

func _on_confirmed() -> void:
	if line_edit.text == "":
		SoundPlayer.play_sfx(preload("uid://cswq161pu075x"))
		line_edit.placeholder_text = "⚠ Please enter a name!"
		line_edit.grab_focus()
		return
		
	if submitted:
		SoundPlayer.play_sfx(preload("uid://cswq161pu075x"))
		line_edit.clear()
		line_edit.placeholder_text = "⚠ Already submitted score!"
		line_edit.grab_focus()
		return
		
	await submit_score(line_edit.text, Global.get_total())
	visible = false
	submitted = true

func _on_canceled() -> void:
	SoundPlayer.play_sfx(preload("uid://6f5s0t2k7h2u"))
	
func submit_score(raw_name: String, score: int) -> void:
	var normalized_name = raw_name.to_lower()
	await Talo.players.identify("username", normalized_name)
	await Talo.leaderboards.add_entry("leaderboard", score)
	print("Score uploaded for:", normalized_name)
