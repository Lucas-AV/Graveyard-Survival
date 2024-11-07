extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(text: String):
	print(text)
	$Label.text = "%.1f" % float(text)

	var tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 8), .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	
	tween.tween_property(self, "global_position",global_position + (Vector2.UP * 24), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale",Vector2.ONE, .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	

	# Encolhe o número quando o processo de animção acaba
	var scale_tween = create_tween()
	scale_tween.tween_property(self,"scale",Vector2.ONE * 2,.15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self,"scale",Vector2.ONE,.15)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	tween.tween_callback(queue_free)
