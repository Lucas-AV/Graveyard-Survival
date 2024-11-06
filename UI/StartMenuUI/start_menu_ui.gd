extends CanvasLayer

func _ready():
	get_window().content_scale_factor = 2
	%StartButton.pressed.connect(on_start_pressed)
	%SettingsButton.pressed.connect(on_settings_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)

var settings = preload("res://UI/SettingsUI/settings_ui.tscn")

func on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Dungeon Planner/example_layer_map.tscn")

func on_settings_pressed():
	self.visible = false
	
	var settings_instance = settings.instantiate()
	add_child(settings_instance)
	settings_instance.back_pressed.connect(on_settings_closed.bind(settings_instance))

func on_settings_closed(settings_instance: Node):
	settings_instance.queue_free()

func on_quit_pressed():
	get_tree().quit()
