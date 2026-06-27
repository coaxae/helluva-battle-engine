extends state

@export var enemycontainer : Node2D
@export var player_heart : CharacterBody2D
@export var buttons_state : state
@export var mercy_enemy_state : state
@export var battle_writer : text_writer

var movesound : AudioStream = preload("res://Assets/Sounds/menu_move.mp3")
var selectsound : AudioStream = preload("res://Assets/Sounds/menu_sel.mp3")

var enemycount = 0
var enemysel = 0
var enemies : Array = []

func state_start():
	enemies = enemycontainer.get_children()
	enemysel = 0
	
	var t : String = ""
	for i in enemies.size():
		t += "  * " + enemies[i].enemy_name + "\n"

	battle_writer.reset_text(t)
	battle_writer.skip()
	

func state_process(delta):
	
	if Input.is_action_just_pressed("Exit"):
		Audio.play_sound(movesound)
		statemachine.switch_state(buttons_state)
	
	enemysel += int(Input.is_action_just_pressed("Down"))
	enemysel -= int(Input.is_action_just_pressed("Up"))
	enemysel = posmod(enemysel, enemies.size())

	if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("Up"):
		if enemies.size() > 1:
			Audio.play_sound(movesound)
	
	player_heart.position = Vector2(
		60, 
		287 + 33 * enemysel
	)
	
	if Input.is_action_just_pressed("Enter"):
		Audio.play_sound(selectsound)
		enemycontainer.selected_enemy = enemysel
		statemachine.switch_state(mercy_enemy_state)
