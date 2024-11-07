extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AudioStreamPlayer.playing = true
	%AudioStreamPlayer.finished.connect(on_theme_finish)

func on_theme_finish():
	
	%AudioStreamPlayer.play()
