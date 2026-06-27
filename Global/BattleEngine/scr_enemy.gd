@icon("res://addons/IconGodotNode/node_2D/icon_character.png")
extends Node
class_name enemy

var animation_timer = 0

@export var enemy_name : String
@export var character : Node2D
@export var text_bubble : Node2D
@export var bubble_writer : text_writer
@export var attack_point : Marker2D

@export var hit_react_sounds : Array[AudioStream]

@export var Health : int = 100
@export var MaxHealth : int = 100

@export var hit_text : Label
@export var healthbar : ProgressBar

@export var acts : Array
@export var check_text : String

@export var spareable : bool = false

var hit_sound = preload("res://Assets/Sounds/snd_damage_c2.wav")

var charx = 0.0

var shake = 0.0

@export var dodge = false


signal writer_finish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_bubble.hide()
	bubble_writer.reset_text("")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation_handler()
	
	healthbar.max_value = float(MaxHealth)
	healthbar.value += (float(Health) - healthbar.value)*0.2 * (60 * delta)
	
	animation_timer += 60 * delta
	
	character.position.x = charx + randf_range(-shake, shake)

	if Input.is_action_just_pressed("Enter") and bubble_writer.done:
		writer_finish.emit()

func animation_handler():
	pass
	
func damage(dam):
	if dodge:
		
		hit_text.show()
		get_tree().create_tween().tween_property(hit_text, "modulate:a", 1, 0.2).from(0)
		hit_text.text = "MISS"
		hit_text.position.y = 0
		hit_text.rotation = 0
		hit_text.add_theme_color_override("font_color", Color.DIM_GRAY)
		
		var dodge_tween = get_tree().create_tween()
		dodge_tween.tween_property(self, "charx", 130 * (randi_range(0,1)*2.0-1.0), 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		dodge_tween.play()
		await dodge_tween.finished
		await get_tree().create_timer(0.2).timeout
		dodge_tween = get_tree().create_tween()
		dodge_tween.tween_property(self, "charx", 0, 1.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		dodge_tween.play()
		
		get_tree().create_tween().tween_property(hit_text, "modulate:a", 0, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		get_tree().create_tween().tween_property(hit_text, "position:y", 20, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		get_tree().create_tween().tween_property(hit_text, "rotation_degrees", 5, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

		
	else:
		healthbar.show()
		get_tree().create_tween().tween_property(healthbar, "modulate:a", 1, 0.3).from(0)
		await get_tree().create_timer(0.8).timeout
		
		hit_text.show()
		get_tree().create_tween().tween_property(hit_text, "modulate:a", 1, 0.2).from(0)
		hit_text.text = str(dam)
		hit_text.position.y = 0
		hit_text.rotation = 0
		
		hit_text.add_theme_color_override("font_color", Color.PALE_VIOLET_RED)
		
		Audio.play_sound(hit_sound, 0.6)
		
		var hit_react = null
		if hit_react_sounds.size() > 0:
			hit_react = hit_react_sounds[randi_range(0, hit_react_sounds.size() - 1)]
		
		if hit_react != null:
			Audio.play_sound(hit_react, 0.5)
		
		Health -= dam
		get_tree().create_tween().tween_property(self, "shake", 0, 0.3).from(10.0)


		await get_tree().create_timer(0.8).timeout
		get_tree().create_tween().tween_property(hit_text, "modulate:a", 0, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		get_tree().create_tween().tween_property(hit_text, "position:y", 20, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		get_tree().create_tween().tween_property(hit_text, "rotation_degrees", 5, 1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		get_tree().create_tween().tween_property(healthbar, "modulate:a", 0, 0.6)

func spare():
	Audio.play_sound(load("res://Assets/Sounds/snd_dust.mp3"))
	get_tree().create_tween().tween_property(self,"modulate:a", 0, 0.6)
	await get_tree().create_timer(0.6).timeout
	self.queue_free()
