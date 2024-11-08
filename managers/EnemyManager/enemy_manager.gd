extends Node

@export var spawn_radius = 330
@export var base_spawn_time = 1.0
@export var limit_time = 0.075
@export var basic_enemy_scene: PackedScene
@export var skeleton_enemy_scene: PackedScene
@export var zombie_enemy_scene: PackedScene
@export var time_manager: TimeManager

var enemy_table = WeightTable.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_table.add_item(basic_enemy_scene,10)
	$Timer.timeout.connect(on_timeout)
	$Timer.wait_time = base_spawn_time
	time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)

func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.75)
	$Timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 9:
		enemy_table.add_item(skeleton_enemy_scene, 20)

	if arena_difficulty == 15:
		enemy_table.add_item(zombie_enemy_scene, 30)

func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player")
	if player == null: return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * spawn_radius)

		# Colisão com terrenos
		var query_parameters = PhysicsRayQueryParameters2D.create(
			player.global_position,
			spawn_position,
			1 # 1 << 0 Usa Bitshaft para poder o id da layer
		)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		
		if(result.is_empty()):
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
		
	return spawn_position
	


func on_timeout():
	$Timer.start()
	var player = get_tree().get_first_node_in_group("player")
	if player == null: return
	
	var enemy_scene = enemy_table.pick_random_item()
	var enemy = enemy_scene.instantiate() as Node2D
	var spawn_layer = get_tree().get_first_node_in_group("entities_layer")
	
	spawn_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()
