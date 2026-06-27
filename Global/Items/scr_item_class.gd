@abstract
extends Resource
class_name Item

enum Type {WEAPON, CONSUMABLE, ARMOUR}

var item_type := Type.CONSUMABLE

var item_name := "Test Item"
var item_serious_name := "T. Item"
var item_normal_name := "TestItem"

var item_desc := "* hello am item"
var restorehp := 0

var heal_sound := preload("res://Assets/Sounds/snd_heal.ogg")

func _init() -> void:
	setup_type()
	setup_item()
func setup_type():
	pass
func setup_item_prop(name:String,ser_name:String,norm_name:String,type:Type,desc:String,healamount:int) -> void:
	item_desc = name
	item_serious_name = ser_name
	item_normal_name = norm_name
	item_desc = desc
	item_type = type
	restorehp = healamount
func setup_item():
	pass
func use_item(item:Item):
	if item!=self:return
	match item_type:
		Type.CONSUMABLE:
			Audio.play_sound(heal_sound)
			Stats.player_hp = clamp(Stats.player_hp,Stats.player_hp + restorehp, Stats.player_max_hp)
			await Engine.get_main_loop().process_frame
			Stats.player_items.remove_at(Stats.player_items.find(self))
		
