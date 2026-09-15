class_name Hotspot
extends Node2D

@export var lifetime : float = 10.0 # how long before it dissapears from map

var player_inside : bool = false
@onready var tele_timer = $TeleTimer

@export var min_pos : Vector2 = Vector2(0, 0)
@export var max_pos : Vector2 = Vector2(160, 144)

func _ready():
	#move to random spot within bounds
	teleport()
	tele_timer.wait_time = lifetime
	tele_timer.start()

func _process(delta):
	if Input.is_action_just_pressed("Interact") and player_inside:
		SceneManager.go_to_panning()


func teleport():
	var new_pos = Vector2(randf_range(min_pos.x, max_pos.x), randf_range(min_pos.y, max_pos.y))
	global_position = new_pos


func _on_tele_timer_timeout():
	teleport()
	tele_timer.start()

func _on_area_2d_body_entered(body):
	player_inside = true

func _on_area_2d_body_exited(body):
	player_inside = false
