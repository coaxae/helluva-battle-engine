extends AnimatedSprite2D

func _process(delta: float) -> void:
	get_child(0).color = self.modulate
