extends Node
class_name UpgradeManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene
@export var upgrades_grid_ui: UpgradesGridUI
var current_upgrades = {}
@export var weapons: Array[String] = ["axe"]

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)
	
func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)

	# Se por o upgrade não existir na tabela de upgrades
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else: 
		current_upgrades[upgrade.id]["quantity"] += 1
		
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func (pool_upgrade): return pool_upgrade.id != upgrade.id)
			
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	if(upgrade.mini_source != null):
		var weapon_name = upgrade.mini_source.weapon_name
		if(!weapons.has(weapon_name)):
			weapons.append(weapon_name)
			upgrades_grid_ui.add_card(upgrade)
	
var reaper_upgrades: Array[String] = [
	"reaper_rate",
	"reaper_damage",
	"reaper_critical_damage",
	"reaper_critical"
]

func pick_upgrades():
	print(weapons)
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()
	# TRABALHANDO AQUI #########################################
	if(!weapons.has("reaper_scythe")):
		filtered_upgrades = filtered_upgrades.filter(func (upgrade): return !reaper_upgrades.has(upgrade.id))
	
	# TRABALHANDO AQUI #########################################
	if !filtered_upgrades.is_empty():
		for i in 3:
			var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
			if chosen_upgrade == null: break
			chosen_upgrades.append(chosen_upgrade)
			filtered_upgrades = filtered_upgrades.filter(func (upgrade): return upgrade.id != chosen_upgrade.id)
	return chosen_upgrades

func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
	
func on_level_up(_current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades: Array[AbilityUpgrade] = pick_upgrades()
	upgrade_screen_instance.current_upgrades = current_upgrades
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
