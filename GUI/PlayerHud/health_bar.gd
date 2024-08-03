class_name HealthBar extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var player : Player
var hp : int = 10

func _set_hp(_hp : int) -> void:
	var prev_hp = hp
	hp = _hp
	value = hp
	
	if hp < prev_hp:
		timer.start()
	else:
		damage_bar.value = hp
	pass 

func init(_hp : int) -> void:
	hp = _hp
	max_value = _hp
	value = _hp
	damage_bar.max_value = _hp
	damage_bar.value = _hp
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	player = PlayerManager.player
	init(PlayerManager.player.hp)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	damage_bar.value = hp
	pass # Replace with function body.
