extends Node2D
class_name DeathComponent
@export var health_component: HealthComponent
@export var sprite: Sprite2D

func _ready():
	$GPUParticles2D.texture = sprite.texture
	health_component.died.connect(on_died)

func on_died():
	if owner == null || not owner is Node2D:
		return
	var spawn_position = owner.global_position
	var entities = get_tree().get_first_node_in_group("entities_layer")
	entities.remove_child(self) # Remove o personagem da árvore principal do jogo
	entities.add_child(self) # Adiciona uma versão baseada no death component
	global_position = spawn_position
	$AnimationPlayer.play("default")
