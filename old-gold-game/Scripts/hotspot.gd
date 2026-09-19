class_name Hotspot
extends Node2D

@export var lifetime : float = 10.0 # how long before it dissapears from map

var player_inside : bool = false

func _process(delta):
	if Input.is_action_just_pressed("Interact") and player_inside:
		SceneManager.go_to_panning()

func _on_area_2d_body_entered(body):
	player_inside = true

func _on_area_2d_body_exited(body):
	player_inside = false
