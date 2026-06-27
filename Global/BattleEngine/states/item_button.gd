extends state

var item_page = 0
var item_sel = 0
var text_page = 0

var movesound : AudioStream = preload("res://Assets/Sounds/menu_move.mp3")
var selectsound : AudioStream = preload("res://Assets/Sounds/menu_sel.mp3")

@export var item_text_state : state
@export var buttons_state : state
@export var battle : battle_engine

var text_blocks := []
@export var textblockholder : Node2D

@export var battle_writer : text_writer
@export var player_heart : CharacterBody2D
func text_block(text:String,pos:Vector2):
	var txtblk = Label.new()
	txtblk.add_theme_font_override("font", load("res://Assets/Fonts/determination_mono.ttf"))
	txtblk.add_theme_font_size_override("font_size", 32)
	txtblk.add_theme_constant_override("outline_size",9)
	txtblk.position = pos
	txtblk.text = text
	txtblk.add_theme_color_override("font_color", Color.GRAY)
	txtblk.size = Vector2(100,100)
	textblockholder.add_child(txtblk)
	return txtblk
func state_start():
	await get_tree().process_frame
	battle_writer.reset_text("")
	item_page = 0
	item_sel = 0
	setup_text_blocks()

func state_stop():
	for i in text_blocks.size():
		text_blocks[i].queue_free()
	text_blocks = []
func state_process(_delta):
	match item_sel - 4*item_page:
		0:player_heart.position = Vector2(60,287)
		1:player_heart.position = Vector2(320,287)
		2:player_heart.position = Vector2(60,337)
		3:player_heart.position = Vector2(320,337)
	item_sel += int(Input.is_action_just_pressed("Right"))
	item_sel -= int(Input.is_action_just_pressed("Left"))
	
	item_sel += int(Input.is_action_just_pressed("Down")) * 2
	item_sel -= int(Input.is_action_just_pressed("Up")) * 2
	item_sel = clamp(item_sel, 0, Stats.player_items.size() - 1)
	
	if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("Up")or Input.is_action_just_pressed("Left")or Input.is_action_just_pressed("Right"):
		if Stats.player_items.size() > 1:
			Audio.play_sound(movesound)
	
	if item_sel > 3:
		item_page = 1
		
	else:
		item_page = 0

	if text_page != item_page:
		setup_text_blocks()
		text_page = item_page

	if Input.is_action_just_pressed("Enter"):
		player_heart.hide()
		match Stats.player_items[item_sel].item_type:
			Stats.player_items[item_sel].Type.CONSUMABLE:
				Stats.player_item_use_text = "* You used the " + Stats.player_items[item_sel].item_name + "![pause=0.5]\n* You restored " + str(Stats.player_items[item_sel].restorehp) + " HPs!"
			_:
				Stats.player_item_use_text = "* You equipped the " + Stats.player_items[item_sel].item_name
		Stats.player_items[item_sel].use_item(Stats.player_items[item_sel])
		Audio.play_sound(selectsound)
		statemachine.switch_state(item_text_state)
	if Input.is_action_just_pressed("Exit"):
		Audio.play_sound(movesound)
		statemachine.switch_state(buttons_state)

func setup_text_blocks():
	for i in text_blocks.size():
		text_blocks[i].queue_free()
	text_blocks = []
	for i in 4:
		if i + 4 * item_page < Stats.player_items.size():
			var item_pos = Vector2.ZERO
			match i:
				0:item_pos = Vector2(52,270)
				1:item_pos = Vector2(320,270)
				2:item_pos = Vector2(52,320)
				3:item_pos = Vector2(320,320)
			if battle.serious_mode:
				text_blocks.append(text_block("  * " + Stats.player_items[i + 3 * item_page].item_serious_name,item_pos))
			else:
				text_blocks.append(text_block("  * " + Stats.player_items[i + 3 * item_page].item_normal_name,item_pos))

	text_blocks.append(text_block("\n    PAGE " + str(item_page+1), Vector2(320,310)))
