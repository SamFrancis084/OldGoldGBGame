#this script will have a bunch of helper functions in it
extends Node

var is_fs : bool = false

var last_pos : Vector2 = Vector2(96, 56)

var default_size : Vector2i = Vector2i(160, 144)
var scaling_factor : float = 4.0

func _ready():
	#await get_tree().process_frame
	change_screen_size(default_size * scaling_factor)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if OS.has_feature("web"):
		# Wait for 1-2 frames so the browser iframe settles
		await get_tree().process_frame
		await get_tree().process_frame
		
		# Force Godot to re-calculate the viewport layout
		var current_size = DisplayServer.window_get_size()
		DisplayServer.window_set_size(current_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Restart"): get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("Fullscreen"): toggle_fullscreen()

func toggle_fullscreen():
	is_fs = !is_fs
	if is_fs:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		#change_screen_size(default_size * scaling_factor)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#change_screen_size(default_size * scaling_factor)

func change_screen_size(new_size : Vector2i):
	get_window().size = new_size
