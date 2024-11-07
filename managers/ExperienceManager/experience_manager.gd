extends Node
class_name ExperienceManager

signal experience_updated(current_experience: float, experience_to_next_level: float)

@export var experience_to_next_level: float = 5
@export var experience_growth_rate: float = 5

var current_experience: float = 4.0
var current_level = 1

signal level_up(new_level: int)

func get_percent_to_next_level() -> float:
	if current_experience == 0: return 0
	return current_experience / experience_to_next_level

func increase(value: float, _positive: bool = true):
	# Basicamente o menor valor entre a soma do xp atual com o valor adicionado e o valor alvo ou seja, uma forma de fazer um limite no sistema de XP
	current_experience = min(current_experience + value, experience_to_next_level)
	experience_updated.emit(current_experience, experience_to_next_level)
	if (current_experience >= experience_to_next_level):
		current_level += 1
		current_experience = current_experience - experience_to_next_level
		experience_to_next_level += experience_growth_rate
		experience_updated.emit(current_experience, experience_to_next_level)
		level_up.emit(current_level)
		MetaProgression.save_upgrades["upgrade_currency"] += value
		MetaProgression.save()
	
func on_collected(value: float):
	increase(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.experience_item_collected.connect(on_collected)
