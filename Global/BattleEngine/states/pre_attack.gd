extends state

@export var player_heart : CharacterBody2D
@export var battle_writer : text_writer
@export var attack_vars : attackvars
@export var attack_state : state

func state_start():
	battle_writer.reset_text("")
	player_heart.position = Vector2(320,320)

	attack_vars.main_attack()

	await attack_vars.pre_done

	statemachine.switch_state(attack_state)
