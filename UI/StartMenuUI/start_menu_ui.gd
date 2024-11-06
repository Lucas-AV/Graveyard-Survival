extends CanvasLayer
class_name StartMenuUI
func _ready():
	get_window().content_scale_factor = 2
	%StartButton.pressed.connect(on_start_pressed)
	%SettingsButton.pressed.connect(on_settings_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	%MetaUpgradesButton.pressed.connect(on_meta_upgrades_pressed)

var settings = preload("res://UI/SettingsUI/settings_ui.tscn")

func on_meta_upgrades_pressed():
	self.visible = false
	var meta_upgrades_instance = preload("res://UI/MetaMenu/meta_menu.tscn").instantiate()
	add_child(meta_upgrades_instance)
	meta_upgrades_instance.back_pressed.connect(on_meta_upgrades_menu_closed.bind(meta_upgrades_instance))

func on_meta_upgrades_menu_closed(meta_upgrades_instance: Node):
	meta_upgrades_instance.queue_free()

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
