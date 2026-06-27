extends state

@export var player_heart : CharacterBody2D
@export var battle_writer : text_writer

func state_start():
	battle_writer.reset_text("")
	player_heart.can_move = true
	player_heart.position = Vector2(320,320)

func state_stop():
	player_heart.can_move = false
