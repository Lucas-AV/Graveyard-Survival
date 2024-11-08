extends CanvasLayer

signal back_pressed

var current_scene = "game"

func on_back_pressed():
	back_pressed.emit()
	get_parent().visible = true


@export var upgrades: Array[MetaUpgrade] =[]
var meta_upgrade_card_scene = preload("res://UI/MetaUpgradeCardUI/meta_upgrade_card_ui.tscn")

func _ready():
	get_window().content_scale_factor = 2.3
	for upgrade in upgrades:
		var meta_upgrade = meta_upgrade_card_scene.instantiate()
		meta_upgrade.set_ability_upgrade(upgrade)
		%GridContainer.add_child(meta_upgrade)
	%ContinueButton.pressed.connect(on_continue_pressed)
	%Current.text = str(MetaProgression.get_upgrade_currency())
	
func on_continue_pressed():
	get_window().content_scale_factor = 1
	if current_scene == "start":
		self.queue_free()
		get_parent().visible = true
		return  
	get_tree().change_scene_to_file("res://UI/MainMenu/main_menu.tscn")

func _process(_delta):
	pass
