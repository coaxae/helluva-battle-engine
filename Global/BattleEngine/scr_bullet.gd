@icon("res://addons/IconGodotNode/node_2D/icon_bullet.png")

extends Node2D
class_name bullet

var SPEED := 0.0
var DIR := Vector2(0,0)
var ROT_SPEED := 0.0
var ROT := 0
var POS := Vector2.ZERO
var BULLET_DAMAGE := 1

func _ready() -> void:
	global_position = Vector2.ZERO
	

func _process(delta: float) -> void:
	POS += DIR * SPEED * 60.0 * delta
	ROT += ROT_SPEED * 60.0 * delta
	self.global_position = POS
	self.global_rotation_degrees = ROT
