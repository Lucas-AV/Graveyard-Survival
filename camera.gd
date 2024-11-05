extends Camera2D
var follow_speed = 15
@export var target: NodePath
@onready var target_node = get_node(target)

func _process(delta):
	if target_node == null: return
	
	# Segue o jogador enquanto ele estiver vivo
	var target_position = target_node.global_position
	global_position = lerp(global_position, target_position, follow_speed * delta)
