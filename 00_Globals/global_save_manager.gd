extends Node


const SAVE_PATH = 'user://'


signal game_loaded
signal game_saved


var current_save : Dictionary = {
	scene_path = '',
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0,
	},
	items = [],
	persistance = [],
	quests = [],
}



func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_items()
	var file := FileAccess.open(SAVE_PATH + 'save.sav', FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass




func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + 'save.sav', FileAccess.READ)
	var _json = JSON.new()
	_json.parse(file.get_line())
	var save_dict : Dictionary = _json.get_data() as Dictionary
	current_save = save_dict
	
	LevelManager.load_new_level(current_save.scene_path, '', Vector2.ZERO)
	
	await LevelManager.level_load_started
		
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()
	pass


func update_player_data() -> void:
	var _player : Player = PlayerManager.player
	current_save.player.hp = _player.hp
	current_save.player.max_hp = _player.max_hp
	current_save.player.pos_x = _player.global_position.x
	current_save.player.pos_y = _player.global_position.y
	pass


func update_scene_path() -> void:
	var _path : String = ''
	for c in get_tree().root.get_children():
		if c is Level:
			_path = c.scene_file_path
	
	current_save.scene_path = _path
	pass


func update_items() -> void:	
	current_save.items = PlayerManager.INVENTORY_DATA.get_saved_data()
	pass


func add_persistent_value(value: String) -> void:
	if check_persistent_value(value):
		return
	
	current_save.persistance.append(value)
	pass

func check_persistent_value( value: String) -> bool:
	var _p = current_save.persistance as Array
	return _p.has(value)
