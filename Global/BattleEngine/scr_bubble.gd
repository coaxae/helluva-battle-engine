extends NinePatchRect
class_name bubble

@export var text : text_writer

func _process(delta: float) -> void:
	size = text.size + Vector2(
		20,
		20
	)
