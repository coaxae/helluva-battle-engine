@icon("res://addons/IconGodotNode/node_2D/icon_square.png")

extends Node2D
class_name bullet_board

@export var walls : Panel
@export var background : Panel
@export var marker : Marker2D
@export var col_poly : CollisionPolygon2D

var size : Vector2 = Vector2(575,140)
var pos : Vector2 = Vector2(320,320)
var rot : float = 0.0

func _process(_delta: float) -> void:

	walls.size = size
	walls.position = pos - size / 2.0
	walls.pivot_offset = size / 2.0
	walls.rotation_degrees = rot

	background.position = walls.position
	background.rotation = walls.rotation
	background.size = walls.size
	background.pivot_offset = walls.pivot_offset

	col_poly.polygon = [
		Vector2(-size.x / 2.0 + 5, -size.y / 2.0 + 5),
		Vector2(size.x / 2.0 - 6, -size.y / 2.0 + 5),
		Vector2(size.x / 2.0 - 6, size.y / 2.0 - 6),
		Vector2(-size.x / 2.0 + 5, size.y / 2.0 - 6)
	]
	col_poly.rotation = walls.rotation
func board_set(size:Vector2, pos:Vector2,rot:float=0.0,time:float=0.3, Trans : Tween.TransitionType = Tween.TRANS_LINEAR, Ease : Tween.EaseType = Tween.EASE_IN_OUT):
	get_tree().create_tween().tween_property(self, "size", size,time).set_ease(Ease).set_trans(Trans)
	get_tree().create_tween().tween_property(self, "pos", pos,time).set_ease(Ease).set_trans(Trans)
	get_tree().create_tween().tween_property(self, "rot", rot,time).set_ease(Ease).set_trans(Trans)
