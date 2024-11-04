extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var collision_area_2d: Area2D = $CollisionArea2D
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals

var speed = 100

var number_of_enemies_colliding_bodies = 0

func _ready():
	collision_area_2d.body_entered.connect(on_enemy_body_entered)
	collision_area_2d.body_exited.connect(on_enemy_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timeout)

# Damage
func check_deal_damage():
	if number_of_enemies_colliding_bodies == 0: return
	health_component.modify(1)
	if damage_interval_timer.is_stopped():
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
	var x_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x_movement, y_movement)

func _process(_delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * speed
	
	move_and_slide()
	
	var move_sign = sign(movement_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)
	position = position.round()
