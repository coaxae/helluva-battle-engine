@icon("res://addons/IconGodotNode/node/icon_camera_grid.png")
extends Node

@export_file("*.tscn") var Init_Scene : String = "Empty"

@export var View : SubViewport
@export var BorderView : SubViewport

var current_scene = null
var main_cam : Camera2D = null
var screen_shake := 0.0

var fullscreen := false

func _ready() -> void:
	change_scene(Init_Scene)

func _process(delta: float) -> void:
	
	if screen_shake > 0.0:
		screen_shake -= 60 * delta
	if screen_shake < 0.0:
		screen_shake = 0.0

	if main_cam != null:
		main_cam.offset = Vector2(
			randf_range(-screen_shake, screen_shake),
			randf_range(-screen_shake, screen_shake)
		)


	if Input.is_action_just_pressed("Fullscreen"):
		fullscreen = !fullscreen
	
	match fullscreen:
		false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func change_scene(scene : String):
	if !current_scene == null:
		current_scene.queue_free()

	var scene_node = null

	if ResourceLoader.exists(scene):
		scene_node = ResourceLoader.load(scene).instantiate()
		if !scene_node == null:
			View.add_child(scene_node)
	current_scene = scene_node
#	BorderView.world_2d = View.world_2d
