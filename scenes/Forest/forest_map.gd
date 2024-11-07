extends Node

@export var death_screen: PackedScene
@export var player: Player

var pause_menu_scene = preload("res://UI/PauseUI/pause_ui.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("pause") && player != null:
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()

func _ready():
	get_window().content_scale_factor = 4
	$entities/Player.health_component.died.connect(on_died)

func on_died():
	await get_tree().create_timer(1.5).timeout
	var death_instance: DeathScreen = death_screen.instantiate()
	$UI/ExperienceBarUI.visible = false
	$UI/TimerUI.visible = false
	add_child(death_instance)
