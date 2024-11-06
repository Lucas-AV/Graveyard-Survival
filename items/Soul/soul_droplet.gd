extends Node2D
class_name SoulDroplet
@export var soul_droplet_config: SoulDropletConfig
@onready var sprite: Sprite2D

var xp_value_table: Array[int] = [1,2,3,5,8,13]

func get_vector2_from_index(index: int):
	var xy_vec: Array[Vector2] = [
		Vector2(0,0),
		Vector2(16,0),
		Vector2(32,0),
		Vector2(0,16),
		Vector2(16,16),
		Vector2(16,32),
	]
	return xy_vec[index]

var xy_vector_region_sprite: Rect2
var xy_index: Vector2

func _ready():
	xy_index = get_vector2_from_index(soul_droplet_config.droplet_index)
	(sprite.texture as AtlasTexture).region = Rect2(xy_index.x,xy_index.y,16,16)
