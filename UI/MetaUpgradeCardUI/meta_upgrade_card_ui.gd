extends PanelContainer

signal selected

@onready var name_label: Label = %Title
@onready var description_label: Label = %Description
@onready var cost_label: Label = %Cost

var upgrade: MetaUpgrade

func _ready():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	gui_input.connect(on_gui_input)
	%PurchaseButton.pressed.connect(on_purchase_pressed)
	validate_price()
	
func set_ability_upgrade(_upgrade: MetaUpgrade):
	self.upgrade = _upgrade
	%Title.text = _upgrade.title
	%Description.text = _upgrade.description
	%Cost.text = str(_upgrade.currency_cost)

func validate_price():
	if self.upgrade == null: return
	var percent = MetaProgression.save_upgrades["upgrade_currency"] / upgrade.currency_cost
	percent = min(percent, 1)
	%PurchaseButton.disabled = percent < 1
	if(%PurchaseButton.disabled == false):
		return false
	return true
	
func on_purchase_pressed():
	if upgrade == null || !validate_price(): return
	MetaProgression.save_upgrades["upgrade_currency"] -= upgrade.currency_cost
	MetaProgression.meta_upgrade_added(upgrade)

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
