extends Node
class_name HealthComponent

signal died
signal damaged
signal healed
signal full_health

@export var max_health: float = 10
var current_health

func _ready() -> void:
	current_health = max_health

func modify(value: float, isDamage: bool = true):
	# damage
	if(isDamage):
		current_health = max(current_health - value, 0)
		Callable(check_death).call_deferred()
		damaged.emit()
	# heal
	else:
		current_health = min(current_health + value, max_health)
		Callable(check_full_health).call_deferred()
		healed.emit()

func get_health_percent():
	if max_health <= 0: return 0
	return min(current_health / max_health, 1)

func check_full_health():
	if current_health == max_health:
		full_health.emit()
func check_death():
	if current_health == 0: 
		died.emit()
		owner.queue_free()
