extends CanvasLayer

@export var experience_manager: ExperienceManager
@onready var progress_bar: ProgressBar = $ExperienceBar

# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	progress_bar.value = experience_manager.get_percent_to_next_level()
	experience_manager.experience_updated.connect(on_experience_updated)
	%Current.text = str(experience_manager.total_experience)

func on_experience_updated(current_experience: float, experience_to_next_level: float):
	var percent = current_experience / experience_to_next_level
	progress_bar.value = percent
	%Current.text = str(experience_manager.total_experience)
