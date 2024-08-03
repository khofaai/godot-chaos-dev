extends CanvasLayer


@onready var progress_bar = $ProgressBar

var player : Player
var hp : int = 10


# Called when the node enters the scene  tree for the first time.
func _ready():
	player = PlayerManager.player
	player.player_damaged.connect(update_hp)
	set_hp(player.hp)
	pass # Replace with function body.

func set_hp(_hp : int) -> void:
	progress_bar.init(_hp)
	pass


func update_hp(hurt_box: HurtBox) -> void:
	progress_bar._set_hp(player.hp)
