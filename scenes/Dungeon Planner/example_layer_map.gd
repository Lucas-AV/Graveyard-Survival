extends Node

@export var death_screen: PackedScene

func _ready():
	$entities/Player.health_component.died.connect(on_died)
	
func on_died():
	var death_instance: DeathScreen = death_screen.instantiate()
	add_child(death_instance)
