extends Node
class_name VelocityComponent

@export var speed: float = 50
@export var acceleration: float = 5
@export var sprite: AnimatedSprite2D
var velocity = Vector2.ZERO

func accelerate(direction: Vector2) -> void:
	var target_velocity = direction * speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * get_process_delta_time()))

func accel_to_player() -> void: 
	var owner_2d = owner as Node2D
	if owner_2d == null: return
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: return
	
	var direction = player.global_position - owner_2d.global_position
	direction = direction.normalized()
	accelerate(direction)

var last_pos: Vector2 = Vector2.ZERO

func move(body: CharacterBody2D) -> void:
	body.velocity = velocity
	if(body.velocity != Vector2.ZERO):
		sprite.play("walking")
	else:
		sprite.play("idle")
	body.move_and_slide()
	
	velocity = body.velocity
