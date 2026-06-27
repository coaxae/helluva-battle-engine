@icon("res://addons/IconGodotNode/node/icon_crate.png")
extends Node
class_name battle_engine

@export var board : bullet_board
@export var battle_writer : text_writer = null
@export var camera : Camera2D
@export var cover_black : ColorRect

@export var can_flee : bool = false

var serious_mode := false

func _ready() -> void:
	board.size = Vector2(400,140)
	Display.main_cam = camera
	get_tree().create_tween().tween_property(cover_black, "modulate:a", 0, 0.8).from(1)

	battle_start()

func battle_start():
	pass
