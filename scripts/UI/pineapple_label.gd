extends Label

@onready var pineapple_label: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_pineapple_text()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_pineapple_text()

func update_pineapple_text() -> void:
	pineapple_label.text = "Pineapples: %d" % Global.picked_pineapples
