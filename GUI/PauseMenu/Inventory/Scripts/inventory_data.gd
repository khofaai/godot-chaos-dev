class_name InventoryData extends Resource


@export var slots : Array[SlotData]


func _init() -> void:
	connect_slots()
	pass

func add_item(item : ItemData, quantity : int = 1) -> bool:
	#this block is when pickup and existing item located in a position != than 0	
	for slot in slots: 
		if slot:
			if slot.item_data == item:
				slot.quantity += quantity
				return true
	
	for i in slots.size():
		if slots[i]:
			if slots[i].item_data == item:
				slots[i].quantity += quantity
				return true
		else:
			var _slot = SlotData.new()
			_slot.item_data = item
			_slot.quantity = quantity
			slots[i] = _slot
			_slot.changed.connect(slot_changed)
			return true
	
	#for i in slots.size():
		#if slots[i] == null:
			#var _slot = SlotData.new()
			#_slot.item_data = item
			#_slot.quantity = quantity
			#slots[i] = _slot
			#return true
	print('inventory full !')
	return false


func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)
	pass


func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
	pass


func get_saved_data() -> Array:
	var item_saved : Array = []
	for i in slots.size():
		item_saved.append(item_to_save(slots[i]))
	return item_saved


func item_to_save(slot : SlotData) -> Dictionary:
	var result = {
		item = '',
		quantity = 0,
	}
	
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	
	return result


func parse_save_data(saved_data: Array) -> void:
	var array_size = slots.size()
	
	slots.clear()
	slots.resize(array_size)
	for i in saved_data.size():
		slots[i] = item_from_save(saved_data[i])
		
	connect_slots()
	pass


func item_from_save(save_object: Dictionary) -> SlotData:
	if save_object.item == '':
		return null
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	return new_slot


func use_item(item : ItemData, count: int = 1) -> bool:
	for s in slots:
		if s and s.item_data == item and s.quantity >= count:
			s.quantity -= count
			return true
	return false
