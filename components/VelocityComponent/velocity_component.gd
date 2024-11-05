extends Node
class_name VelocityComponent

@export var max_speed: float = 50
@export var acceleration: float = 5
@export var animation_player: AnimationPlayer
var velocity = Vector2.ZERO

func accelerate(direction: Vector2) -> void:
	var target_velocity = direction * max_speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * get_process_delta_time()))

func accel_to_player() -> void: 
	var owner_2d = owner as Node2D
	if owner_2d == null: return
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	var direction = player.global_position - owner_2d.global_position
	direction = direction.normalized()
	accelerate(direction)
	
func move(body: CharacterBody2D) -> void:
	body.velocity = velocity
	body.move_and_slide()
	
	velocity = body.velocity
