extends ConfirmationDialog

@onready var line_edit: LineEdit = $LineEdit

var submitted = false

func _on_confirmed() -> void:
	if line_edit.text == "":
		line_edit.placeholder_text = "⚠ Please enter a name!"
		line_edit.grab_focus()
		return
	submit_score()
	visible = false
	submitted = true
	
func submit_score() -> void:
	if submitted:
		line_edit.placeholder_text = "⚠ Already submitted score!"
		line_edit.grab_focus()
		return
	api.upload_score(line_edit.text, Global.get_total())
