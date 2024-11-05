extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var collision_area_2d: Area2D = $CollisionArea2D
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals

@export var speed = 600

var number_of_enemies_colliding_bodies = 0

func _ready():
	collision_area_2d.body_entered.connect(on_enemy_body_entered)
	collision_area_2d.body_exited.connect(on_enemy_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timeout)

# Damage
func check_deal_damage():
	if number_of_enemies_colliding_bodies == 0: return
	health_component.modify(1)
	damage_interval_timer.start()
		
func on_damage_interval_timeout():
	check_deal_damage()

# Enemy Collision
func on_enemy_body_entered(_other_body: Node2D):
	number_of_enemies_colliding_bodies += 1
	check_deal_damage()

func on_enemy_body_exited(_other_body: Node2D):
	number_of_enemies_colliding_bodies -= 1

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)

func _process(_delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * speed
	
	move_and_slide()
	
	if movement_vector.x != 0 || movement_vector.y != 0:
		animation_player.play("RESET")
	else:
		animation_player.play("idle")
	
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)
	position = position.round()
