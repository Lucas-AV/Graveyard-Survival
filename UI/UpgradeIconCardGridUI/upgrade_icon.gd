extends PanelContainer
class_name IconCardGridUI

@onready var texture_rect: TextureRect = %TextureRect
@export var weapon: WeaponSource

func _ready():
	get_window().content_scale_factor = 4
	texture_rect.texture = weapon.texture
