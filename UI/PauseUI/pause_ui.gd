extends CanvasLayer

var is_closing: bool = false

#%ResumeButton, %RestartButton, %SettingsButton, %QuitButton
# Called when the node enters the scene tree for the first time.
func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	%ResumeButton.pressed.connect(on_resume)
	%RestartButton.pressed.connect(on_restart)
	%SettingsButton.pressed.connect(on_settings)
	%QuitButton.pressed.connect(on_quit)

func _unhandled_input(event):
	if event.is_action_pressed("pause") && !is_closing:
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
func on_restart(): get_tree().reload_current_scene()
func on_settings(): pass
func on_quit(): get_tree().quit()
