extends Resource
class_name WeaponSource

@export_enum(
	"axe", "axe_gem",
	"sword", "sword_gem",
	"scythe", "scythe_gem", 
	"chakram", "chakram_gem",
	"hammer", "hammer_gem",
	"reaper_scythe", "reaper_scythe_gem"
) var weapon_name: String

@export var texture: Texture
