extends Node

signal current_ability_triggered()
signal current_ability_finished()

var current_ability : PlayerAbilities = null


func ability_triggered(ability: PlayerAbilities, _actionName: String) -> void:
	current_ability_triggered.emit()
	current_ability = ability
	pass

func ability_finished(ability) -> void:
	current_ability_finished.emit(ability)
	pass
