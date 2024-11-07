extends Node
const save_path = "user://game.save"


var save_upgrades: Dictionary = {
	"upgrade_currency":0,
	"upgrades":{}
}

func get_upgrade_currency():
	return save_upgrades["upgrade_currency"]

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
		if(upgrade.porcentage > 0.0):
			save_upgrades["upgrades"][upgrade.id] = {
				"porcentage": upgrade.porcentage,
				"quantity": 0,
			}
	save_upgrades["upgrades"][upgrade.id]["quantity"] += 1
	save()
	
func on_soul_collected(number: float = 1):
	save_upgrades["upgrade_currency"] += number


# Gets
func get_meta_upgrade(id: String):
	var meta_upgrade: Dictionary = save_upgrades["upgrades"][id]
	return meta_upgrade

func get_quantity_from_meta_upgrade(id: String) -> int:
	var meta_upgrade: Dictionary = get_meta_upgrade(id)
	var quantity: int = meta_upgrade["quantity"]
	return quantity

func get_porcentage_from_meta_upgrade(id: String) -> float:
	var meta_upgrade: Dictionary = get_meta_upgrade(id)
	var porcentage: float = meta_upgrade["porcentage"]
	return porcentage
	
func get_math_pow_upgrade(id: String):
	var quantity: int = get_quantity_from_meta_upgrade(id)
	var porcentage: float = get_porcentage_from_meta_upgrade(id)
	return pow(quantity, porcentage)
