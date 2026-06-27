extends Node

@onready var name_lv = $main_ui/name_lv
@onready var health_bar = $main_ui/hp_bar
@onready var post_pos = $main_ui/after_bar
@onready var hp_text = $main_ui/after_bar/hp_hpmax
@onready var kr_label = $main_ui/after_bar/kr_label

func _process(delta: float) -> void:
	
	health_bar.value = Stats.player_hp
	health_bar.max_value = Stats.player_max_hp
	
	health_bar.size.x = 1.21 * Stats.player_max_hp
	hp_text.text = str(Stats.player_hp) + " / " + str(Stats.player_max_hp)
	
	
	
	name_lv.text = Stats.player_name + " LV " + str(Stats.player_lv)
	post_pos.position.x = health_bar.position.x + health_bar.size.x + 14

	match Stats.player_curse:
		Stats.player_curses.NONE:
			hp_text.position.x = 0
			kr_label.hide()
		Stats.player_curses.KR:
			hp_text.position.x = 32
			kr_label.show()
			
			if Stats.player_kr > 0:
				hp_text.modulate = Color.MAGENTA
				kr_label.modulate = Color.MAGENTA
			else:
				hp_text.modulate = Color.WHITE
				kr_label.modulate = Color.WHITE
