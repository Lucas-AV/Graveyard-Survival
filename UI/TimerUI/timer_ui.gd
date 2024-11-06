extends CanvasLayer

@export var time_manager: Node
@onready var label = %Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if time_manager == null: return
	
	var time_elapsed = time_manager.get_time_elapsed()
	label.text = format_seconds(time_elapsed)

func format_seconds(seconds: float):
	var minutes = floor(seconds / 60)
	var reamining_seconds = floor(seconds - (minutes * 60))
	return "%02d" % minutes + ":" + "%02d" % reamining_seconds
