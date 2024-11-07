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
		var percent_reudction = pow(0.9,upgrade_quantity)
		$Timer.wait_time = base_wait_time * percent_reudction
		$Timer.start()
	
	elif(upgrade.id == "chakram_damage"):
		damage = damage * pow(1.1, upgrade_quantity)
	

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(
		func(enemy: Node2D): return enemy.global_position.distance_squared_to(
			player.global_position
		) < pow(max_range, 2)
	)
	if enemies.size() == 0: return
	
	enemies.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_distance = a.global_position.distance_squared_to(player.global_position)
			var b_distance = b.global_position.distance_squared_to(player.global_position)
			return a_distance < b_distance
	)
	
	var ability_scene_instance = ability_scene.instantiate() as ChakramAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(ability_scene_instance)
	ability_scene_instance.hitbox_component.damage = damage
	
	ability_scene_instance.global_position = enemies[0].global_position
	ability_scene_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemies[0].global_position - ability_scene_instance.global_position
	ability_scene_instance.rotation = enemy_direction.angle()
