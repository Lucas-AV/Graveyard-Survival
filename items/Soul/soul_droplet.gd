extends Node2D
class_name SoulDroplet

@export var droplet_index: int = 0
@export_range(0,5) var xp_value_index: int = 0
@export var xp_value_table: Array[int] = [1,2,3,5,8,13]

func get_vector2_from_index(droplet_index: int):
	var xy_vec: Array[Vector2] = [
		Vector2(0,0),
		Vector2(16,0),
		Vector2(32,0),
		Vector2(0,16),
		Vector2(16,16),
		Vector2(16,32),
	]
	return xy_vec[droplet_index]

var x_index
var y_index
@onready var sprite: Sprite2D
var xy_vector_region_sprite: Rect2

func _ready():
	var xy_index = get_vector2_from_index(droplet_index)
	x_index = xy_index.x
	y_index = xy_index.y
	xy_vector_region_sprite = Rect2(x_index,y_index,16,16)
	(sprite.texture as AtlasTexture).region = xy_vector_region_sprite
