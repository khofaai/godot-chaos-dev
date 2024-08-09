class_name EnemyCounter extends Node


signal enemies_defeated


func _ready() -> void:
	child_exiting_tree.connect(_on_enemy_destroyed)
	pass


func _on_enemy_destroyed(_enemy : Node2D) -> void:
	if _enemy is Enemy:
		if enemy_count() <= 1: # 1 because of frame late 
			enemies_defeated.emit()
	pass


func enemy_count() -> int:
	var _count : int = 0
	for c in get_children():
		if c is Enemy:
			_count += 1
	return _count
