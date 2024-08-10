@icon("res://npc/icons/npc_behavior.svg")
class_name NPCBehavior extends Node2D

var npc : NPC



func _ready() -> void:
	var _parent = get_parent()
	if _parent is NPC:
		npc = _parent
		npc.do_behavior_enabled.connect(start)
	pass


func start() -> void:
	pass
