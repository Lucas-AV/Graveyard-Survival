extends PanelContainer

signal selected

@onready var name_label: Label = %Title
@onready var description_label: Label = %Description
@onready var current_level_label: Label = %CurrentLevel
func _ready():
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	current_level_label.text = "Lv. 0/%d" % upgrade.max_quantity

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
