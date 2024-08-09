extends Node

signal level_load_started
signal level_loaded
signal tile_map_bounds_changed(bounds: Array[Vector2])

var current_tilemap_bounds : Array[Vector2]
var target_transition : String
var position_offset : Vector2

var loading_freeze : bool = false

func _ready():
	await get_tree().process_frame
	level_loaded.emit()
	pass

func change_tile_map_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tile_map_bounds_changed.emit(bounds)
	pass


func load_new_level(
	level_path : String,
	_target_transition : String,
	_position_offset : Vector2
) -> void:
	
	if loading_freeze:
		return
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in() # Level transition
	
	get_tree().paused = false
	
	await get_tree().process_frame

	level_loaded.emit()	
	
	loading_freeze = true
	await get_tree().create_timer(.1).timeout
	loading_freeze = false
	
	pass
