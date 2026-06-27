extends ColorRect

@export var board : bullet_board

func _process(delta: float) -> void:
	self.size = board.size - Vector2(10,10)
	self.position = board.marker.global_position
	self.rotation_degrees = board.rot
