extends Node
class_name weapon

@export var damage = 0
var final_damage = 0
var hits = 0

var enemy_to_hit : enemy = null



signal done
var is_finished = false

@export var attack_eye : AnimatedSprite2D = null

@export var bars : Array[AnimatedSprite2D] = []

func _ready() -> void:
	get_tree().create_tween().tween_property(attack_eye, "scale:x", 1, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC).from(0.1)
	get_tree().create_tween().tween_property(attack_eye, "modulate:a", 1, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC).from(0.1)

	self.z_index = 1

	bars_go()
func bars_go():
	pass
func attack_enemy():
	pass
