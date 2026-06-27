extends attack


@export var enemy_to_speak_1 : enemy
@export var enemy_2 : enemy
# Called when the node enters the scene tree for the first time.
func run_attack() -> void:
	
	board.board_set(Vector2(140,140),Vector2(320,320), 0,1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	if enemy_to_speak_1 != null and enemy_2 != null:
		enemy_to_speak_1.bubble_writer.reset_text("hi this is test text\n:3")
		enemy_to_speak_1.text_bubble.show()
	
	
		await get_tree().process_frame
		await enemy_to_speak_1.writer_finish
	
		enemy_to_speak_1.text_bubble.hide()
		enemy_to_speak_1.bubble_writer.reset_text("")
	
		enemy_2.bubble_writer.reset_text("hello-")
		enemy_2.text_bubble.show()
	
	
		await get_tree().process_frame
		await enemy_2.writer_finish
	
		enemy_to_speak_1.bubble_writer.reset_text("shut the [shake][color=red]FUCK[/color][/shake]\nup todd.")
		enemy_to_speak_1.text_bubble.show()
	
		enemy_2.bubble_writer.reset_text("")
		enemy_2.text_bubble.hide()
	
	
		await get_tree().process_frame
		await enemy_to_speak_1.writer_finish
	
		enemy_to_speak_1.bubble_writer.reset_text("")
		enemy_to_speak_1.text_bubble.hide()
	
	if enemy_to_speak_1 != null and enemy_2 == null:
		enemy_to_speak_1.bubble_writer.reset_text("todd[pause=0.1].[pause=0.1].[pause=0.1].")
		enemy_to_speak_1.text_bubble.show()
		
		await enemy_to_speak_1.writer_finish
		
		enemy_to_speak_1.bubble_writer.reset_text("i miss you todd...")
		enemy_to_speak_1.text_bubble.show()
		
		await enemy_to_speak_1.writer_finish
	
		enemy_to_speak_1.bubble_writer.reset_text("")
		enemy_to_speak_1.text_bubble.hide()
	
	await get_tree().create_timer(0.2).timeout
	preover.emit()
	
	for i in 4:
		a_vars.test_bullet(Vector2(440, randf_range(280, 340)), Vector2(-1, 0), 1, 0, 2)
		await get_tree().create_timer(2).timeout
	await get_tree().create_timer(2).timeout
	
	over.emit()
