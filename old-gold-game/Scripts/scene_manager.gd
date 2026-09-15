extends Node

@export var main_scene : PackedScene = preload("uid://bc0fn8uflceuh")
@export var panning_scene : PackedScene = preload("uid://ecjclnd0ubth")

func go_to_panning():
	change_scene(panning_scene)

func go_to_main():
	change_scene(main_scene)

func change_scene(scene : PackedScene):
	get_tree().change_scene_to_packed(scene)
