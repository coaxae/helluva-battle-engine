extends state

@export var battle_writer : text_writer
@export var attack_vars : attackvars

@export var buttoncontainer : Node2D
@export var enemycontainer : Node2D

@export var player_heart : CharacterBody2D
@export var state_fight_button : state
@export var state_act_button : state
@export var state_item_button : state
@export var state_mercy_button : state
@export var board : bullet_board

var movesound : AudioStream = preload("res://Assets/Sounds/menu_move.mp3")
var selectsound : AudioStream = preload("res://Assets/Sounds/menu_sel.mp3")
var buttons : Array = []

var selected_button = 0

func state_start():
	
	board.board_set(Vector2(575,140),Vector2(320,320), 0,1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	player_heart.show()
	battle_writer.reset_text(attack_vars.boxtexts[attack_vars.attack_id])
	buttons = buttoncontainer.get_children()
func state_stop():
	pass
func state_process(_delta):

	selected_button += int(Input.is_action_just_pressed("Right"))
	selected_button -= int(Input.is_action_just_pressed("Left"))
	selected_button = posmod(selected_button, buttons.size())

	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		if buttons.size() > 1:
			Audio.play_sound(movesound)
	

	for i in buttons.size():
		if i == selected_button:
			buttons[i].frame = 1
			player_heart.position = buttons[i].global_position + Vector2(-39,0)
		else:
			buttons[i].frame = 0
	if Input.is_action_just_pressed("Enter"):
		Audio.play_sound(selectsound)
		match selected_button:
			0:
				statemachine.switch_state(state_fight_button)
			1:
				statemachine.switch_state(state_act_button)
			2:
				if Stats.player_items.size() > 0:
					statemachine.switch_state(state_item_button)
			3:
				statemachine.switch_state(state_mercy_button)
