extends state

@export var enemycontainer : Node2D
@export var player_heart : CharacterBody2D
@export var buttons_state : state
@export var mercy_button_state : state
@export var flee_state : state
@export var battle_writer : text_writer

@export var battle : battle_engine

var movesound : AudioStream = preload("res://Assets/Sounds/menu_move.mp3")
var selectsound : AudioStream = preload("res://Assets/Sounds/menu_sel.mp3")

var action_sel = 0
var can_interact = true

func state_start():
	action_sel = 0
	can_interact = true
	var t : String = "  * Spare\n  * Flee"

	battle_writer.reset_text(t)
	battle_writer.skip()
	

func state_process(delta):
	
	if Input.is_action_just_pressed("Exit") and can_interact:
		Audio.play_sound(movesound)
		statemachine.switch_state(mercy_button_state)
	if can_interact:
		action_sel += int(Input.is_action_just_pressed("Down"))
		action_sel -= int(Input.is_action_just_pressed("Up"))
		action_sel = posmod(action_sel, 2)

	if Input.is_action_just_pressed("Down") and can_interact or Input.is_action_just_pressed("Up") and can_interact:
		Audio.play_sound(movesound)
	
	player_heart.position = Vector2(
		60, 
		287 + 33 * action_sel
	)
	
	if Input.is_action_just_pressed("Enter") and can_interact:
		Audio.play_sound(selectsound)
		
		match action_sel:
			0:
				if enemycontainer.get_child(enemycontainer.selected_enemy).spareable:
					enemycontainer.get_child(enemycontainer.selected_enemy).spare()
					can_interact = false
					await get_tree().create_timer(1.0).timeout
					statemachine.switch_state(buttons_state)
			1:
				if battle.can_flee:
					flee()
func flee():
	pass
