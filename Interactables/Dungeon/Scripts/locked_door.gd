class_name LockedDoor extends Node2D


var is_open : bool = false

@export var key_item : ItemData #type of item can open this door
@export var lock_audio : AudioStream
@export var open_audio : AudioStream


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_open_data : PersistanceDataHandler = $PersistanceDataHandler
@onready var interact_area : Area2D = $InteractArea2D
@onready var label : Label = $Label


func _ready() -> void:
	update_label('Press [E] to open', false)
	
	interact_area.area_entered.connect(_on_area_enter)
	interact_area.area_exited.connect(_on_area_exit)
	is_open_data.data_loaded.connect(set_state)
	set_state()
	pass


func open_door() -> void:
	if key_item == null:
		return

	var door_unlocked : bool = PlayerManager.INVENTORY_DATA.use_item(key_item)
	
	if door_unlocked:
		animation_player.play('open_door')
		audio.stream = open_audio
		is_open_data.set_value()
		is_open = true
		label.visible = false
	else:
		audio.stream = lock_audio
		update_label('Need KEY to open !', true)

	audio.play()
	pass


func close_door() -> void:
	animation_player.play('close_door')
	pass


func set_state() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play('opened')
		label.visible = false
	else:
		animation_player.play('closed')
	pass


func _on_area_enter(_area : Area2D) -> void:
	update_label('Press [E] to open', true)
	PlayerManager.interact_pressed.connect(open_door)
	pass


func _on_area_exit(_area : Area2D) -> void:
	update_label('Press [E] to open', false)
	PlayerManager.interact_pressed.disconnect(open_door)
	pass

func update_label(_text: String, _visible: bool) -> void:
	if !is_open:
		label.visible = _visible
		label.text = _text
	pass
