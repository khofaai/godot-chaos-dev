class_name FireBall extends Node2D


@onready var cpu_particles : CPUParticles2D = $CPUParticles2D
var player : Player
var direction : Vector2
var speed : float = 0
var ability_name : String = 'fireball'
var is_active : bool = false

@export var acceleration : float = 500.0
@export var max_speed : float = 400.0
@export var cooldown : int = 1

func _ready() -> void:
	cpu_particles.emitting = false
	player = PlayerManager.player
	AbilityManager.current_ability_triggered.connect(_on_ability_triggered)
	pass


func _physics_process(_delta: float) -> void:
	speed -= acceleration * _delta
	position += direction * speed * _delta
	pass

func throw(_direction: Vector2) -> void:
	#global_position = player.global_position
	if is_active:
		return
	is_active = true
	cpu_particles.emitting = true
	direction = _direction
	speed = max_speed
	wait_cooldown()
	pass


func wait_cooldown() -> void:
	print('cooldown: ', cooldown)
	await get_tree().create_timer(cooldown).timeout
	AbilityManager.ability_finished(self)
	queue_free()
	pass


func _on_ability_triggered(_abilty: PlayerAbilities) -> void:
	pass

