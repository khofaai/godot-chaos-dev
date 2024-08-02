class_name EnemyStateWander extends EnemyState


@export var animation_name : String = 'walk'
@export var wander_speed : float = 20.0


@export_category('AI')
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction : Vector2


func init() -> void:
	pass

## What happens when player enter this State?
func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var randIndex = randi_range(0, 3)
	_direction = enemy.DIR_4[randIndex]
	
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(animation_name)
	pass


## What happens when player exit this State?
func exit() -> void:
	pass


## What happens during _process update in this State?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	
	if _timer < 0:
		return next_state
	return null


## What happens during _physics_process update in this State?
func physics(_delta: float) -> EnemyState:
	return null

