class_name InventoryUI extends Control

const INVENTORY_SLOTS = preload("res://GUI/PauseMenu/Inventory/inventory_slot.tscn")

@export var data : InventoryData

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()
	data.changed.connect(on_inventory_changed)
	pass


func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
	pass


func update_inventory() -> void:
	for _s in data.slots:
		var new_slot = INVENTORY_SLOTS.instantiate()
		add_child(new_slot)
		new_slot.slot_data = _s
	
	await get_tree().create_timer(0.02).timeout
	
	for c in get_children():
		if c.slot_data:
			await get_tree().create_timer(0.05).timeout
			c.grab_focus()
			return
	#if get_child(0).slot_data:
		#get_child(0).grab_focus()
	pass


func on_inventory_changed() -> void:
	clear_inventory()
	update_inventory()
	pass

