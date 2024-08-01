class_name Plant extends Node2D

@onready var hit_box = $HitBox


# Called when the node enters the scene tree for the first time.
func _ready():
	hit_box.Damaged.connect(TakeDamage)
	pass # Replace with function body.


func TakeDamage(_damage: int) -> void:
	queue_free()
	pass
