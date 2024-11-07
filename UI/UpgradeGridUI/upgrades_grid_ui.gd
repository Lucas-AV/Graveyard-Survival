extends CanvasLayer
class_name UpgradesGridUI

@export var upgrade_card_scene: PackedScene


func add_card(upgrade: AbilityUpgrade):
	var icon_instance = upgrade_card_scene.instantiate()
	icon_instance.weapon = upgrade.mini_source
	%UpgradeIconGridContainer.add_child(icon_instance)
