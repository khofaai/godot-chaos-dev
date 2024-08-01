class_name State_Idle extends State


@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"


## What happens when player enter this State?
func Enter() -> void:
	player.UpdateAnimation('idle')
	pass


## What happens when player exit this State?
func Exit() -> void:
	pass


## What happens during _process update in this State?
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null


## What happens during _physics_process update in this State?
func Physics(_delta: float) -> State:
	return null


## What happens with input events in this State?
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed('attack'):
		return attack
	return null

