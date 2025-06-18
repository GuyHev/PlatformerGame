extends Node

var picked_pineapples = 0
var life = 3
var position = Vector2.ZERO  # Store position data only
var levels: Node = null

func set_levels_reference(node: Node) -> void:
	levels = node
