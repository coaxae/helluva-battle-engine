extends state
@export var battle_writer : text_writer

@export var buttons_state : state
var can_finish := false
func state_start():
	await get_tree().process_frame
	battle_writer.reset_text(Stats.player_item_use_text)
	
func state_process(_delta):
	if battle_writer.done and Input.is_action_just_pressed("Enter"):
		statemachine.switch_state(buttons_state)
