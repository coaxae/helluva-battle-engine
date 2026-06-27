extends Node

var player_name : String = "DEVELOPER"

var player_lv : int = 1
var player_hp : int = 92
var player_max_hp : int = 92
var player_kr : int = 0

var player_item_use_text := ""
var player_invincibilty := 0.0

var player_items : Array[Item] = [
TestEdible.new(),
TestEdible.new(),
TestEdible.new(),
TestEdible.new(),
TestEdible.new()
]


enum player_curses {
	NONE,
	KR
}

var player_curse : player_curses = player_curses.NONE

var player_weapon = preload("res://Global/BattleEngine/weapon/weapon_knife.tscn")

func _physics_process(_delta: float) -> void:
	player_max_hp = 16 + 4 * player_lv
	player_hp = clamp(player_hp, 0, player_max_hp)
	

	if Input.is_action_just_pressed("Menu"):
		player_hurt(5)

func player_hurt(amount):
	match player_curse:
		player_curses.NONE:
			if player_invincibilty <= 0:
				Display.screen_shake = 5
				Audio.play_sound(load("res://Assets/Sounds/snd_damage_player.ogg"))
				player_hp = clamp(player_hp, 0, player_hp - amount)
				get_tree().create_tween().tween_property(self, "player_invincibilty", 0, 1).from(60)
