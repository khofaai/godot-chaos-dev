extends CanvasLayer


@onready var progress_bar = $ProgressBar
@onready var ability_01 = $Abilities/Ability01
@onready var ability_02 = $Abilities/Ability02
@onready var ability_02_timer = $Abilities/Ability02/Ability02Timer

var abilityMap : Dictionary = {
	boomerang = null,
	fireball = null
}

var player : Player
var hp : int = 10

# Called when the node enters the scene  tree for the first time.
func _ready():
	player = PlayerManager.player
	player.player_damaged.connect(update_hp)
	player.player_hp_updated.connect(update_hp_value)
	SaveManager.game_loaded.connect(set_loaded_data)
	set_hp(player.hp)
	AbilityManager.current_ability_triggered.connect(_set_ability)
	AbilityManager.current_ability_finished.connect(_finish_ability)
	abilityMap.boomerang = ability_01
	abilityMap.fireball = ability_02
	pass # Replace with function body.

func set_hp(_hp : int) -> void:
	progress_bar.init(_hp)
	pass

func update_hp(_hurt_box: HurtBox) -> void:
	progress_bar._set_hp(player.hp)

func update_hp_value(hp : int) -> void:
	progress_bar._set_hp(hp)

func set_loaded_data() -> void:
	progress_bar._set_hp(player.hp)

#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ability_01"):
		#_set_ability("ability_01")
	#elif event.is_action_pressed("ability_02"):
		#_set_ability("ability_02")
	#pass

func _set_ability(_ability) -> void:
	if abilityMap[_ability.ability_name]:
		abilityMap[_ability.ability_name].modulate = Color(1, 1, 1, 0.3)
	pass

func _finish_ability(_ability) -> void:
	if abilityMap[_ability.ability_name]:
		abilityMap[_ability.ability_name].modulate = Color(1, 1, 1, 1)
	pass
	
