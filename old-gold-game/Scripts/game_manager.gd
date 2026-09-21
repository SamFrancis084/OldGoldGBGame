#this script will have a bunch of helper functions in it
extends Node

var is_fs : bool = false

var last_pos : Vector2 = Vector2(96, 56)

var default_size : Vector2i = Vector2i(160, 144)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Restart"): get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("Fullscreen"): toggle_fullscreen()

func toggle_fullscreen():
	is_fs = !is_fs
	if is_fs:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func change_screen_size(new_size : Vector2i):
	get_window().size = new_size
