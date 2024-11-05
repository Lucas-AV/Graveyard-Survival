extends CharacterBody2D
class_name BasicEnemy

@export var max_speed = 50
@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _process(_delta: float) -> void: 
	velocity_component.accel_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		$Visuals/AnimatedSprite2D.play("walking")
		visuals.scale = Vector2(move_sign, 1)
	else:
		$Visuals/AnimatedSprite2D.play("idle")
