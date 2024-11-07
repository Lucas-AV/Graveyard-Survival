extends Node

@export var max_range: float = 100
@export var ability_scene: PackedScene
@export var damage: float = 5

var valid_chakram_upgrades: Array[String] = ["chakram_rate","chakram_damage","chakram_critical_damage","chakram_critical_rate"]

var base_wait_time: float


func _ready() -> void:
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	self.damage = ceil(damage)
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id not in valid_chakram_upgrades: return
	var upgrade_quantity = current_upgrades[upgrade.id]["quantity"]

	# chakram_rate
	if(upgrade.id == "chakram_rate"):
		var percent_reudction = pow(0.95,upgrade_quantity)
		$Timer.wait_time = base_wait_time * percent_reudction
		$Timer.start()
	
	elif(upgrade.id == "chakram_damage"):
		damage = damage * pow(1.05, upgrade_quantity)
	

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground_layer == null: return
	
	var chakram_ability_instance = ability_scene.instantiate() as ChakramAbility
	foreground_layer.add_child(chakram_ability_instance)
	chakram_ability_instance.hitbox_component.damage = damage
	chakram_ability_instance.global_position = player.global_position
