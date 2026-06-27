extends state

@export var enemy_container : Node2D

@export var scroll_show : AnimatedSprite2D
@export var battle_writer : text_writer
@export var player_heart : CharacterBody2D

@export var act_text_state : state
@export var act_button_state : state

var movesound : AudioStream = preload("res://Assets/Sounds/menu_move.mp3")
var selectsound : AudioStream = preload("res://Assets/Sounds/menu_sel.mp3")

var text_to_use : String


var act_sel : int = 0

var act_names : Array[String]

var enemy_to_act : enemy
var act_count = 0
func state_start():
	act_names = []
	enemy_to_act = enemy_container.get_child(enemy_container.selected_enemy)
	act_sel = 0
	scroll_show.frame = 0
	scroll_show.play()

	act_count = 1 + enemy_to_act.acts.size()
	act_names.append("Check")
	for i in act_count:
		if enemy_to_act.acts.size() != 0:
			act_names.append(enemy_to_act.acts[i].act_name)

func state_stop():
	scroll_show.frame = 0
	scroll_show.stop()
	scroll_show.hide()

func state_process(_delta):
	player_heart.position = Vector2(
		60, 
		320
	)
	
	act_sel += int(Input.is_action_just_pressed("Down"))
	act_sel -= int(Input.is_action_just_pressed("Up"))
	act_sel = posmod(act_sel, act_names.size())

	if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("Up"):
		if act_names.size() > 1:
			Audio.play_sound(movesound)
	
	if Input.is_action_just_pressed("Exit"):
		Audio.play_sound(movesound)
		statemachine.switch_state(act_button_state)
	
	if Input.is_action_just_pressed("Enter"):
		if act_sel > 0:
			text_to_use = enemy_to_act.acts[act_sel].text
		else:
			text_to_use = enemy_to_act.check_text
		Audio.play_sound(selectsound)
		statemachine.switch_state(act_text_state)
	
	if act_names.size() > 1:
		scroll_show.show()
	
	battle_writer.visible_characters = -1
	if act_sel == 0:
		battle_writer.text = "[color=gray]\n"
		
		
		
		for i in 2:
			if i < act_names.size():
				battle_writer.text += "  * " + act_names[i] + "\n"
		
	if act_sel > 0 and act_sel < act_names.size() - 1:
		battle_writer.text = "[color=gray]"
		
		
		
		for i in 3:
			if i < act_names.size():
				battle_writer.text += "  * " + act_names[act_sel - 1 + i] + "\n"
		
	if act_sel > 1 and act_sel == act_names.size() - 1:
		battle_writer.text = "[color=gray]"
		
		
		
		for i in 2:
			if i < act_names.size():
				battle_writer.text += "  * " + act_names[act_sel - 1 + i] + "\n"
		
