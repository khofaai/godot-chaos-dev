class_name AbilityHud extends Node2D


@export var ability_texture : Sprite2D
@export var action_name : String = ''


@onready var sprite : Sprite2D = $Panel/Sprite2D
@onready var label : Label = $Panel/Label


@onready var panel = $Panel
@onready var sub_panel = $Panel/Panel2


func _ready() -> void:
	pass


func highlight_ability() -> void:
	
	pass
