extends CanvasLayer
@export var player: Player
@onready var progress_bar: ProgressBar = %ProgressBar
var _health_component: HealthComponent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_health_component = player.health_component
	progress_bar.max_value = _health_component.max_health
	progress_bar.value = _health_component.current_health
	_health_component.modified.connect(on_modify)

func on_modify():
	#var percent = _health_component.current_health / progress_bar.max_value
	progress_bar.value = _health_component.current_health
