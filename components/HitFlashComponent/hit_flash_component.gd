extends Node
class_name HitFlashComponent
@export var health_component: HealthComponent
@export var sprite: Sprite2D

@export var material: ShaderMaterial
var tween: Tween

func _ready():
	health_component.damaged.connect(on_damaged)
	sprite.material = material as ShaderMaterial
	
func on_damaged():
	if tween != null && tween.is_valid() || tween.is_running():
		tween.kill()
		
	sprite.material.set_shader_parameter("lerp_percent",1.0)
	tween = create_tween()
	tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, .25)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
