extends PanelContainer

signal selected

@onready var name_label: Label = %Title
@onready var description_label: Label = %Description
@onready var current_level_label: Label = %CurrentLevel
func _ready():
	gui_input.connect(on_gui_input)
var current_upgrades

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	
	if current_upgrades.has(upgrade.id):
		current_level_label.text = "Lv. %d" % current_upgrades[upgrade.id]["quantity"] + "/%d" % upgrade.max_quantity
	else:
		current_level_label.text = "Lv. 0/%d" % upgrade.max_quantity
	
	if upgrade.texture_icon != null:
		%TextureIcon.texture = upgrade.texture_icon
	if upgrade.texture_icon_evolution != null:
		%TextureIconEvolution.texture = upgrade.texture_icon_evolution

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
