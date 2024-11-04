extends CharacterBody2D
class_name BasicEnemy

@export var max_speed = 50
@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals = $Visuals

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if(player_node != null):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

func _process(_delta: float) -> void: 
	var direction = get_direction_to_player()
	velocity = direction * max_speed
	move_and_slide()
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(-move_sign, 1)
