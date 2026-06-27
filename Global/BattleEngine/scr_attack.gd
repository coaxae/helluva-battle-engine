extends Node
class_name attack

signal preover
signal over

@export var board : bullet_board

var a_vars : attackvars

func _init() -> void:
	a_vars = get_parent()

func run_attack():
	pass
