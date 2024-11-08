extends Node2D
class_name ChakramAbility


@onready var hitbox_component: HitboxComponent = $HitboxComponent

var base_rotation: Vector2 = Vector2.RIGHT
const MAX_RADIUS: float = 75

func tween_method(rotations: float):
	var percent: float = rotations / 2
	var current_radius: float = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	global_position = player.global_position + (current_direction * current_radius)

func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 3.0, 2)
	tween.tween_callback(queue_free)
	
