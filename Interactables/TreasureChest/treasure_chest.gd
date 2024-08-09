@tool
class_name TreasureChest extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

var is_open : bool = false


@onready var sprite: Sprite2D = $ItemSprite2D
@onready var label: Label = $ItemSprite2D/Label
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interact_area : Area2D = $Area2D

@onready var is_open_data = $IsOpen

func _ready() -> void:
	_update_texture()
	_update_label()
	if Engine.is_editor_hint():
		return
	
	interact_area.area_entered.connect(_on_area_enter)
	interact_area.area_exited.connect(_on_area_exit)
	is_open_data.data_loaded.connect(set_chest_state)
	set_chest_state()
	pass


func set_chest_state() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play('opened')
	else:
		animation_player.play('closed')
	pass

func player_interact() -> void:
	if is_open:
		return
	
	is_open = true
	is_open_data.set_value()
	animation_player.play('open_chest')
	
	if item_data and quantity > 0:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr('empty chest !')
		push_error('empty chest ! in: ', name)
	pass


func _on_area_enter(_a: Area2D) -> void:
	PlayerManager.interact_pressed.connect(player_interact)
	pass


func _on_area_exit(_a: Area2D) -> void:
	PlayerManager.interact_pressed.disconnect(player_interact)
	pass



func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()
	pass


func _set_quantity(_quantity : int) -> void:
	quantity = _quantity
	_update_label()
	pass


func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
	pass


func _update_label() -> void:
	if label:
		label.text = 'x ' + str(quantity)
	pass
