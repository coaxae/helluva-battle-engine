extends Node
class_name attackvars

var attack_id : int = 0
var attacks : Array[attack]
@export_multiline var boxtexts : Array[String]

signal pre_done

@onready var statemachine = $"../battle_state_machine"
@export var in_buttons_state : state
@export var bullet_holder : Node2D
@export var bullet_mask : ColorRect

var testbullet = preload("res://Unique/Bullets/bullet_test.tscn")

func _ready() -> void:
	for i in get_children():
		attacks.append(i)
		i.a_vars = self

func main_attack():
	
	
	attacks[attack_id].run_attack()
	await attacks[attack_id].preover
	
	pre_done.emit()
	
	await attacks[attack_id].over
	
	for i in bullet_holder.get_children():
		if i != bullet_mask:
			i.queue_free()
	for i in bullet_mask.get_children():
		i.queue_free()

	statemachine.switch_state(in_buttons_state)

func test_bullet(position : Vector2, direction : Vector2, speed : float, rotation : float, rotationspeed : float, masked : bool = true):
	var bul = testbullet.instantiate()
	bul.SPEED = speed
	bul.POS = position
	bul.DIR = direction
	bul.ROT = rotation
	bul.ROT_SPEED = rotationspeed
	
	if masked:
		bullet_mask.add_child(bul)
	else:
		bullet_holder.add_child(bul)
	
	return bul
