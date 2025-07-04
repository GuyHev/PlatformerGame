extends Label

@onready var score_label: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score_text()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_score_text()
	
func update_score_text() -> void:
	score_label.text = "score: %d" % Global.score
