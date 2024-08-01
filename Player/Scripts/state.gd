class_name State extends Node

# Store the reference to the player that this state belongs to
static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


## What happens when player enter this State?
func Enter() -> void:
	pass


## What happens when player exit this State?
func Exit() -> void:
	pass


## What happens during _process update in this State?
func Process(_delta: float) -> State:
	return null


## What happens during _physics_process update in this State?
func Physics(_delta: float) -> State:
	return null


## What happens with input events in this State?
func HandleInput(_event: InputEvent) -> State:
	return null

