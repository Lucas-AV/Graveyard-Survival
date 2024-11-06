extends CharacterBody2D
class_name Player

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var collision_area_2d: Area2D = $CollisionArea2D
@onready var visuals = $Visuals
@onready var animator = %AnimatedSprite2D
@onready var progress_bar: ProgressBar = %ProgressBar
@export var speed = 200

var number_of_enemies_colliding_bodies = 0

var y_facing: int = 0; # none, -1 down, 1 up

func load_meta_upgrades():
	if MetaProgression.save_upgrades.has("meta_max_health"):
		health_component.max_health = health_component.max_health * MetaProgression.get_math_pow_upgrade("meta_max_health")
	elif MetaProgression.save_upgrades.has("meta_move_speed"):
		speed = speed * MetaProgression.get_math_pow_upgrade("meta_move_speed")
	elif MetaProgression.save_upgrades.has("meta_defense"):
		health_component.defense += MetaProgression.get_quantity_from_meta_upgrade("meta_defense")

func _ready():
	collision_area_2d.body_entered.connect(on_enemy_body_entered)
	collision_area_2d.body_exited.connect(on_enemy_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timeout)
	health_component.modified.connect(on_modified)
	load_meta_upgrades()
	
	progress_bar.max_value = health_component.max_health
	progress_bar.value = health_component.current_health

func on_modified():
	progress_bar.value = health_component.current_health

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
	var movement_vector: Vector2 = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * speed
	
	# Um sobreescreve o outro
	if Input.is_action_just_pressed("move_up"):
		y_facing = -1 
	if Input.is_action_just_pressed("move_down"): 
		y_facing = 1
	if Input.is_action_just_pressed("move_right") || Input.is_action_just_pressed("move_left"):
		y_facing = 0
	move_and_slide()
	
	# horizontal state machine for last x known position
	var move_sign = sign(movement_vector.x)
	if(move_sign != 0):
		visuals.scale = Vector2(move_sign, 1)
		
	if movement_vector.x != 0 || movement_vector.y != 0:
		if(movement_vector.y != 0): # Previnir sobreposição de animação de direção quando está se movimentando
			if(y_facing == 1):
				$Visuals/AnimatedSprite2D.play("walking_front")
			elif(y_facing == -1):
				$Visuals/AnimatedSprite2D.play("walking_back")
		else:
			$Visuals/AnimatedSprite2D.play("walking")

	else:
		if(y_facing == 1):
			$Visuals/AnimatedSprite2D.play("idle_front")
		elif(y_facing == -1):
			$Visuals/AnimatedSprite2D.play("idle_back")
		else:
			$Visuals/AnimatedSprite2D.play("idle")
	
	position = position.round()
