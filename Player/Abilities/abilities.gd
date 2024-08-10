class_name PlayerAbilities extends Node

signal ability_triggered

const BOOMERANG = preload('res://Player/boomerang.tscn')
const FIREBALL = preload('res://Player/Abilities/Particules/fire_ball.tscn')

enum Abilities { BOOMERANG, GRAPPLE, FIREBALL }

var selected_ability = Abilities.BOOMERANG
var player: Player
var boomerang_instance : Boomerang = null
var fireball_instance : FireBall = null


func _ready() -> void:
	player = PlayerManager.player
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_01"):
		if selected_ability == Abilities.BOOMERANG:
			boomerang_ability()
	elif event.is_action_pressed("ability_02"):
		fireball_ability()
	pass


func boomerang_ability() -> void:
	if boomerang_instance != null:
		return
	var _boomerang = BOOMERANG.instantiate() as Boomerang
	player.add_sibling(_boomerang)
	_boomerang.global_position = player.global_position
	
	var throw_direction = player.direction
	if throw_direction == Vector2.ZERO:
		throw_direction = player.cardinal_direction
	_boomerang.throw(throw_direction)
	boomerang_instance = _boomerang
	AbilityManager.current_ability_triggered.emit(_boomerang)
	pass


func fireball_ability() -> void:
	if is_instance_valid(fireball_instance):
		return
	var _fireball = FIREBALL.instantiate() as FireBall
	player.add_sibling(_fireball)
	_fireball.global_position = player.global_position
	
	var throw_direction = player.direction
	if throw_direction == Vector2.ZERO:
		throw_direction = player.cardinal_direction
	_fireball.throw(throw_direction)
	fireball_instance = _fireball
	AbilityManager.current_ability_triggered.emit(_fireball)
	pass
