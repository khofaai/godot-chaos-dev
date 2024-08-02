class_name EnemyStateIdle extends EnemyState


@export var animation_name : String = 'idle'

@export_category('AI')
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : EnemyState

var _timer : float = 0.0



func init() -> void:
	pass

## What happens when player enter this State?
func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.update_animation(animation_name)
	pass


## What happens when player exit this State?
func exit() -> void:
	pass


## What happens during _process update in this State?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	
	if _timer <= 0:
		return after_idle_state
	return null


## What happens during _physics_process update in this State?
func physics(_delta: float) -> EnemyState:
	return null

