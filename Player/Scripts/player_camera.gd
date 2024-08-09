class_name PlayerCamera extends Camera2D
@onready var player = $".."


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.tile_map_bounds_changed.connect(update_limits)
	update_limits(LevelManager.current_tilemap_bounds)
	#center_camera()
	#PlayerManager.player_spawned.connect(focus_player)
	pass # Replace with function body.

func update_limits(bounds : Array[Vector2]) -> void:
	if bounds.size() == 0:
		return
	
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	pass

func center_camera() -> void:
	var left = limit_left + (offset.x * zoom.x) + (get_viewport().size.x * zoom.x) / 2
	var right = limit_right - (offset.x * zoom.x) - (get_viewport().size.x * zoom.x) / 2
	var top = limit_top + (offset.y * zoom.y) + (get_viewport().size.y * zoom.y) / 2
	var bottom = limit_bottom - (offset.y * zoom.y) - (get_viewport().size.y * zoom.y) / 2
	
	position.x = clamp(position.x, left, right)
	position.y = clamp(position.y, top, bottom)

func focus_player(_new_position: Vector2) -> void:
	position.x = _new_position.x / 2
	position.y = _new_position.y / 2
