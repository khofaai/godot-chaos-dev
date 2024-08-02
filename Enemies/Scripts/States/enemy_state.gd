class_name EnemyState extends Node


## Store reference to the enemy
var enemy : Enemy
var state_machine : EnemyStateMachine

func init() -> void:
	pass

## What happens when player enter this State?
func enter() -> void:
	pass


## What happens when player exit this State?
func exit() -> void:
	pass


## What happens during _process update in this State?
func process(_delta: float) -> EnemyState:
	return null


## What happens during _physics_process update in this State?
func physics(_delta: float) -> EnemyState:
	return null

