extends Control

@export var can_skip : bool = true

@export var typeSPD = 0.1
@export var string_array: Array[String]
@export var i = 0
@export var wait_time  = 0.0
@export var pause_time = 0.0

var main_scene : PackedScene = preload("uid://bc0fn8uflceuh")

func _ready():
	
	show_word()
	

func _input(event):
	if not can_skip: return
	
	if event.is_action_pressed("Interact") and not event.echo:
		if i == string_array.size():
			$Sprite2D/AnimationPlayer.play("titlecard_rise")
			i += 1
			#get_tree().change_scene_to_packed(main_scene)
		elif i > string_array.size():
			get_tree().change_scene_to_packed(main_scene)
		else:
			i += 1
			show_word()

func _process(delta):
	
	if $RichTextLabel.visible_ratio <1:
		$RichTextLabel.visible_ratio+=typeSPD*delta
		$RichTextLabel.visible_ratio = min($RichTextLabel.visible_ratio, 1.0)
		wait_time += delta
		return
		
	if wait_time >= 1.0 && i < string_array.size():
		
		pause_time += delta
		
	if pause_time > wait_time:
		i += 1
		pause_time = 0.0
		if i >= string_array.size():
			#$RichTextLabel.text = ""
			$Sprite2D/AnimationPlayer.play("titlecard_rise")
		else:
			show_word()
		

func show_word():
	if i >= string_array.size(): return #safety check
	
	$RichTextLabel.text = string_array[i]
	$RichTextLabel.visible_ratio = 0.0
	wait_time = 0.0
