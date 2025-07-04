extends Label

@onready var life_label: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_life_text()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_life_text()

func update_life_text() -> void:
	life_label.text = "Lives: %d" % Global.life
