extends Node
const save_path = "user://game.save"


var save_upgrades: Dictionary = {
	"upgrade_currency":0,
	"upgrades":{}
}

func _ready():
	GameEvents.meta_currency_upgrade_collected.connect(on_soul_collected)
	
func load_save_file():
	if !FileAccess.file_exists(save_path):
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	save_upgrades = file.get_var()
	
	
func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(save_upgrades)
	
func meta_upgrade_added(upgrade: MetaUpgrade):
	if !save_upgrades["upgrades"].has(upgrade.id): # se não tiver o upgrade no dicionário
		save_upgrades["upgrades"][upgrade.id] = {
			"quantity": 0,
		}
	save_upgrades["upgrades"][upgrade.id]["quantity"] += 1
	print(save_upgrades)
	
func on_soul_collected(number: float = 1):
	save_upgrades["upgrade_currency"] += number
