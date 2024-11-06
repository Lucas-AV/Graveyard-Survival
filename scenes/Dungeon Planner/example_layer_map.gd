extends Node

@export var death_screen: PackedScene

var pause_menu_scene = preload("res://UI/PauseUI/pause_ui.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()

func _ready():
	get_window().content_scale_factor = 4
	$entities/Player.health_component.died.connect(on_died)
	
func on_died():
	var death_instance: DeathScreen = death_screen.instantiate()
	await get_tree().create_timer(1.5).timeout
	add_child(death_instance)
