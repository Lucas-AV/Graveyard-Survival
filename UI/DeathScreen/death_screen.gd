extends CanvasLayer
class_name DeathScreen

func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Dungeon Planner/example_layer_map.tscn")

func on_quit_pressed():
	get_tree().quit()

func on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MetaMenu/meta_menu.tscn")
	

func _ready():
	MetaProgression.save()
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	%ContinueButton.pressed.connect(on_continue_pressed)
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
