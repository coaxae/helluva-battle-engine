@icon("res://addons/IconGodotNode/node/icon_gear.png")

extends Node
class_name state_machine

@export var init_state : state = null
var current_state = null
var states : Array[state] = []

func switch_state(tar_state : state):
	current_state.state_stop()
	current_state = tar_state
	print("switched to: ", tar_state)
	tar_state.state_start()

func _ready() -> void:
	for i in get_children():
		states.append(i)

	await get_tree().process_frame

	current_state = init_state
	current_state.state_start()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta)
