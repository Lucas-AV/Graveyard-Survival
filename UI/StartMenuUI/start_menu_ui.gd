extends CanvasLayer
class_name StartMenuUI


func _ready():
	get_window().content_scale_factor = 1
	%StartButton.pressed.connect(on_start_pressed)
	%SettingsButton.pressed.connect(on_settings_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	%MetaUpgradesButton.pressed.connect(on_meta_upgrades_pressed)

var settings = preload("res://UI/SettingsUI/settings_ui.tscn")
var meta_upgrades = preload("res://UI/MetaMenu/meta_menu.tscn")

func on_meta_upgrades_pressed():
	self.visible = false
	var meta_upgrades_instance = meta_upgrades.instantiate()
	meta_upgrades_instance.current_scene = "start"
	add_child(meta_upgrades_instance)
	#get_tree().change_scene_to_file("res://UI/MetaMenu/meta_menu.tscn")

func on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Forest/forest_map.tscn")

func on_settings_pressed():
	self.visible = false
	
	var settings_instance = settings.instantiate()
	add_child(settings_instance)
	settings_instance.back_pressed.connect(on_settings_closed.bind(settings_instance))

func on_settings_closed(settings_instance: Node):
	settings_instance.queue_free()

func on_quit_pressed():
	get_tree().quit()
