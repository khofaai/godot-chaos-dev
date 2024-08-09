extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is PushableStatue:
		body.push_direction = PlayerManager.player.direction
	pass


func _on_body_exited(body: Node2D) -> void:
	if body is PushableStatue:
		body.push_direction = Vector2.ZERO
	pass
