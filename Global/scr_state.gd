@icon("res://addons/IconGodotNode/node/icon_puzzle.png")
extends Node
class_name state

@onready var statemachine : state_machine = get_node_or_null("..")

func state_start():
	pass
func state_stop():
	pass
func state_process(delta):
	pass
