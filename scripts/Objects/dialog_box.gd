extends Label


@onready var label: Label = $"."
@onready var dialog_box: MarginContainer = $"../.."

const  VISIBILITY_TIMER = 2.0

var full_text: String = ""
var typing_speed := 0.09
var padding := Vector2(30, 30)


func _ready():
	label.text = ""
	show_text("Hello fellow traveller. Collect all pineapples")

func show_text(input_text: String):
	full_text = input_text
	start_typing()

func start_typing():
	var i = 0
	while i <= full_text.length():
		label.text = full_text.substr(0, i)
		# Let Label update its layout first
		await get_tree().process_frame
		# Wait for typing speed delay
		await get_tree().create_timer(typing_speed).timeout
		i += 1
	await get_tree().create_timer(VISIBILITY_TIMER).timeout
	dialog_box.queue_free()
	
