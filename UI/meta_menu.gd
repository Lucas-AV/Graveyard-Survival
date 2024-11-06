extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] =[]
var meta_upgrade_card_scene = preload("res://UI/MetaUpgradeCardUI/meta_upgrade_card_ui.tscn")

func _ready():
	get_window().content_scale_factor = 2
	for upgrade in upgrades:
		var meta_upgrade = meta_upgrade_card_scene.instantiate()
		%GridContainer.add_child(meta_upgrade)
		
func _process(_delta):
	pass
