extends Area2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $Polygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polygon_2d.polygon = collision_polygon_2d.polygon
	polygon_2d.global_position = collision_polygon_2d.global_position
	polygon_2d.scale = collision_polygon_2d.scale

#emit signal when an Area2D object enter the water
func _on_area_entered(area: Area2D) -> void:
	Signals.on_enter_water.emit(area)
	
#emit signal when an Area2D object exit the water
func _on_area_exited(area: Area2D) -> void:
	Signals.on_exit_water.emit(area)
