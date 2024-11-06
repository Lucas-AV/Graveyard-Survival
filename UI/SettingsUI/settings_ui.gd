extends CanvasLayer

signal back_pressed

func _ready():
	setup_fullscreen_button_checkbox_pressed()
	setup_sliders()
	%MusicSlider.value_changed.connect(on_audio_slider_changed.bind("music"))
	%EffectsSlider.value_changed.connect(on_audio_slider_changed.bind("effects"))
	%BackButton.pressed.connect(on_back_pressed)
	%FullscreenCheckbox.pressed.connect(on_fullscreen_pressed)


func set_audio_data(name: String, percent: float):
	var index = AudioServer.get_bus_index(name)
	var volume = linear_to_db(percent)
	AudioServer.set_bus_volume_db(index, volume)


func on_audio_slider_changed(value: float, name: String):
	set_audio_data(name, value)

func setup_sliders():
	%MusicSlider.value = get_audio_data("music")
	%EffectsSlider.value = get_audio_data("effects")
# Setup
func setup_fullscreen_button_checkbox_pressed():
	var mode = DisplayServer.window_get_mode()
	%FullscreenCheckbox.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN

# Sliders
func get_audio_data(name: String):
	var index = AudioServer.get_bus_index(name)
	var volume = AudioServer.get_bus_volume_db(index)
	return db_to_linear(volume)

# Buttons
func on_fullscreen_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func on_back_pressed():
	back_pressed.emit()
	get_parent().visible = true
