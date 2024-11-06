extends CanvasLayer

var is_closing: bool = false
var is_setting_pressed: bool = false
var settings_instance

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	%ResumeButton.pressed.connect(on_resume)
	%RestartButton.pressed.connect(on_restart)
	%SettingsButton.pressed.connect(on_settings)
	%QuitButton.pressed.connect(on_quit)

func _unhandled_input(event):
	if event.is_action_pressed("pause") && !is_closing:
		if(is_setting_pressed):
			self.visible = true
			is_setting_pressed = false
			on_settings_closed(settings_instance)
		else:
			close()
		get_tree().root.set_input_as_handled()

func close(): 
	var tween = create_tween()
	tween.tween_property($MarginContainer/PanelContainer, "scale", Vector2.ONE, .0)
	tween.tween_property($MarginContainer/PanelContainer, "scale", Vector2.ZERO, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	await tween.finished
	get_tree().paused = false
	queue_free()

func on_resume(): close()
func on_restart(): 
	get_tree().paused = false
	get_tree().reload_current_scene()

var settings = preload("res://UI/SettingsUI/settings_ui.tscn")
func on_settings():
	is_setting_pressed = true
	self.visible = false
	settings_instance = settings.instantiate()
	add_child(settings_instance)
	settings_instance.back_pressed.connect(on_settings_closed.bind(settings_instance))

func on_settings_closed(settings_instance: Node):
	settings_instance.queue_free()

func on_quit():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://UI/StartMenuUI/start_menu_ui.tscn")
