extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var pineapples: Node = $"../pineapples"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not are_pineapples_remaining():
		sprite_2d.visible = true

func _on_body_entered(_body: Node2D) -> void:
	if not are_pineapples_remaining():
		LevelManager.load_next_level(get_tree().current_scene)

func are_pineapples_remaining() -> bool:
	return pineapples.get_child_count() > 0
