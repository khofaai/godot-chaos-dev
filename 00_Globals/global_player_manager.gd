extends Node

const PLAYER = preload("res://Player/player.tscn")

var player : Player
var player_spawn : bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawn = true
	pass

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass

func set_health(hp : int, max_hp : int) -> void:
	player.max_hp = max_hp
	player.hp = hp
	pass


func set_player_position(_new_position : Vector2) -> void:
	player.global_position = _new_position
	pass


func set_as_parent(_parent : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_parent.add_child(player)
	pass


func unparent_player(_parent : Node2D) -> void:
	_parent.remove_child(player)
