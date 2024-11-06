extends PanelContainer

signal selected

@onready var name_label: Label = %Title
@onready var description_label: Label = %Description

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade: MetaUpgrade):
	%Title.text = upgrade.title
	%Description.text = upgrade.description
	print(upgrade.title)

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
