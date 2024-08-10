class_name Player extends CharacterBody2D

signal DirectionChanged(new_direction: Vector2)
signal player_damaged(hurt_box : HurtBox)
signal player_hp_updated(delta : int)


var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]


var invulnerable : bool = false
var hp : int = 10
var max_hp : int = 10


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer

@onready var hit_box : HitBox = $HitBox
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

@onready var audio : AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D




# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	hit_box.Damaged.connect(_take_damage)
	#PlayerHud.set_hp(max_hp)
	
	#update_hp(99)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis('left', 'right'),
		Input.get_axis('up', 'down')
	)
	direction = direction.normalized()
	pass


func _physics_process(_delta):
	move_and_slide();


func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	#if direction.y == 0:
		#new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#elif direction.x == 0:
		#new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	var angle = (direction + cardinal_direction * 0.1).angle()
	var val = round((angle / TAU) * DIR_4.size())
	var direction_id : int = int(val)
	
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true


func update_animation(state: String) -> void:
	animation_player.play(state + "_" + animation_direction())
	pass


func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"


func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable:
		return;
	
	update_hp(-hurt_box.damage)
	
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		#update_hp(99)
	pass


func update_hp(delta : int) -> void:
	var new_hp = hp + delta
	if new_hp > max_hp:
		hp = max_hp
	elif new_hp < 0:
		hp = max_hp # should be dead
	else:
		hp = new_hp
	#hp = clampi(hp + delta, 0, max_hp)
	
	player_hp_updated.emit(hp)
	pass


func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass

