extends state

@export var acting_enemy_state : state
@export var in_buttons_state : state
@export var player_heart : CharacterBody2D
@export var battle_writer : text_writer
@export var button_container : Node2D

func state_start():
	await get_tree().process_frame
	for i in button_container.get_child_count():
		button_container.get_child(i).frame = 0
	player_heart.hide()
	battle_writer.reset_text(acting_enemy_state.text_to_use)
func state_process(_delta):
	if battle_writer.done and Input.is_action_just_pressed("Enter"):
		statemachine.switch_state(in_buttons_state)
		await get_tree().process_frame
		player_heart.show()
