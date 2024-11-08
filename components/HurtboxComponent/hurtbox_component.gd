extends Area2D
class_name HurtboxComponent

signal hit

@export var health_component: HealthComponent

var floating_text_scene = preload("res://UI/FloatingNumber/floating_text.tscn")

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(other_area: Area2D):
	if(not other_area is HitboxComponent): return
	if health_component == null: return
	
	var hitbox_component = other_area as HitboxComponent
	health_component.modify(hitbox_component.damage)
	var previous = $"../VelocityComponent".speed
	$"../VelocityComponent".speed = 5
	await get_tree().create_timer(0.5).timeout
	$"../VelocityComponent".speed = previous
	
	# Instancia do texto flutuante
	var text_instance = floating_text_scene.instantiate() as Node2D
	text_instance.scale = 0.75
	get_tree().get_first_node_in_group("foreground_layer").add_child(text_instance)
	
	# Instancia de text na poisção de spawn da hitbox
	text_instance.global_position = global_position + (Vector2.UP * 16)
	text_instance.start(str(hitbox_component.damage))
	
	hit.emit()
