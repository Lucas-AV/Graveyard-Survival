extends Node
class_name TimeManager
signal arena_difficulty_increased(arena_difficulty: int)

@export var difficult_interval = 3
@export var victory_screen_scene: PackedScene
@onready var timer: Timer = $Timer

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

var arena_difficulty = 0

func _process(_delta): 
	var next_time_target = $Timer.wait_time - ((arena_difficulty + 1) + difficult_interval)
	if $Timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)
		
func get_time_elapsed():
	return $Timer.wait_time - $Timer.time_left

func on_timer_timeout():
	var victory_screen_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_instance)
