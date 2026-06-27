extends state

@export var enemycontainer : Node2D
@export var player_heart : CharacterBody2D
@export var battle_writer : text_writer
@export var buttoncontainer : Node2D
@export var in_buttons_state : state
@export var pre_attack_state : state

var player_weapon : weapon = null

var enemysel = 0

func state_start():
	
	enemysel = enemycontainer.selected_enemy
	
	player_weapon = Stats.player_weapon.instantiate()
	add_child(player_weapon)
	player_weapon.enemy_to_hit = enemycontainer.get_child(enemysel)
	player_weapon.position = Vector2(320,320)
	
	for i in buttoncontainer.get_child_count():
		buttoncontainer.get_child(i).frame = 0
	
	battle_writer.reset_text("")
	player_heart.hide()
	
	await player_weapon.done
	if player_weapon.is_finished:
		statemachine.switch_state(pre_attack_state)
	else:
		statemachine.switch_state(in_buttons_state)
	
	player_weapon.queue_free()
	player_heart.show()
	
