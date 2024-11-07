extends Node

@export var max_range: float = 150
@export var sword_ability: PackedScene
@export var damage: float = 5

var valid_sword_upgrades: Array[String] = ["sword_rate","sword_damage"]

var base_wait_time: float


func _ready() -> void:
	
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id not in valid_sword_upgrades: return
	
	var upgrade_quantity = current_upgrades[upgrade.id]["quantity"]
	
	# sword_rate
	if(upgrade.id == "sword_rate"):
		var percent_reudction = pow(0.9,upgrade_quantity)
		$Timer.wait_time = base_wait_time * percent_reudction
		$Timer.start()
	
	elif(upgrade.id == "sword_damage"):
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
	
	var sword_ability_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_ability_instance)
	sword_ability_instance.hitbox_component.damage = damage
	
	sword_ability_instance.global_position = enemies[0].global_position
	sword_ability_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemies[0].global_position - sword_ability_instance.global_position
	sword_ability_instance.rotation = enemy_direction.angle()
	
