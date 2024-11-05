extends Node
class_name HitFlashComponent
@export var health_component: HealthComponent
@export var sprite: AnimatedSprite2D

@export var hit_material: ShaderMaterial
var tween: Tween

func _ready():
	health_component.damaged.connect(on_damaged)
	sprite.material = hit_material
	
func on_damaged():
	if tween != null && tween.is_valid():
		tween.kill()
		
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent",0.9)
	tween = create_tween()
	tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, .2)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
