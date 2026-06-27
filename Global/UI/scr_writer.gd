@icon("res://addons/IconGodotNode/control/icon_dialog.png")

extends RichTextLabel
class_name text_writer

@export var pause : float = 2.0
var current_timer : float = 0.0

@export var sound_file : AudioStream
@export var sound_vol : float = 1.0

var real_text : String = ""

var pause_regex := RegEx.new()

var pause_points : Array = []  # [{pos, duration}]

var done : bool = false
signal text_finished

func _ready() -> void:
	pause_regex.compile(r"\[pause=([0-9]*\.?[0-9]+)\]")

func _physics_process(delta : float) -> void:
	
	if Input.is_action_just_pressed("Exit") and visible_characters > 0:
		skip()
	
	current_timer -= 1 * (60 * delta)
	#var results = pause_regex.search_all(real_text)
	if current_timer <= 0.0 and visible_characters < len(text) and visible_characters != -1:
		visible_characters += 1
		
		if !check_silent() and visible_characters < len(get_parsed_text()):
			if sound_file != null:
				Audio.play_sound(sound_file, sound_vol)

		current_timer = pause
		
		for point in pause_points:
			if visible_characters == point["pos"]:
				current_timer = 60.0 * point["duration"]
				#print("Pause at: ", point["pos"], " duration: ", point["duration"])

	if visible_characters == len(get_parsed_text()) or visible_characters == -1:
		if !done:
			text_finished.emit()
		done = true

func load_font(fontfile : String, fontsize : int = 13):
	add_theme_font_override("normal_font", load(fontfile))
	add_theme_font_size_override("normal_font_size", fontsize)

func reset_text(txt : String):
	visible_characters = 0
	real_text = txt
	pause_points.clear()
	
	var offset = 0
	text = real_text
	real_text = get_parsed_text()
	for result in pause_regex.search_all(real_text):
		var adjusted_pos : int = result.get_start() - offset
		pause_points.append({
			"pos": adjusted_pos,
			"duration": float(result.get_string(1))
		})
		offset += result.get_end() - result.get_start()
	
	text = pause_regex.sub(txt, "", true)

func check_silent():
	match text[visible_characters - 1]:
		" ":
			return true
		_:
			return false

func skip():
	visible_characters = -1
