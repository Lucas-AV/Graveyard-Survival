extends Node

@export_range(0,1) var drop_rate: float
@export var item_scene: PackedScene
@export var item_config: Resource
@export var health_component: Node

var item_instance
func _ready() -> void:
	if(item_scene.get_class() == "SoulDroplet"):
		item_instance = item_scene.instantiate() as Node2D
		(item_instance as SoulDroplet).soul_droplet_config = item_config
	(health_component as HealthComponent).died.connect(on_died)

func on_died():
	if randf() > drop_rate: return
	if item_scene == null: return
	if not owner is Node2D: return
	var spawn_position = (owner as Node2D).global_position
	
	var spawn_layer = get_tree().get_first_node_in_group("entities_layer")
	spawn_layer.add_child(item_instance)
	item_instance.global_position = spawn_position
