extends Node

@export_range(0,1) var drop_rate: float
@export var item_scene: PackedScene
@export var health_component: Node

#func _ready() -> void:
	#(health_component as HealthComponent).died.connect(on_died)
#
#func on_died():
	#if randf() > drop_rate: return
	#
	## Prevenção de erros
	#if item_scene == null: return
	#if not owner is Node2D: return
	#
	#var spawn_position = (owner as Node2D).global_position
	#var item_instance = item_scene.instantiate() as Node2D
	#
	#var spawn_layer = get_tree().get_first_node_in_group("entities_layer")
	#spawn_layer.add_child(item_instance)
	#item_instance.global_position = spawn_position
