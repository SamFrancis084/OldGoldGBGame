extends Node2D

@export var offset_dist : float = 100.0
var start_pos : Vector2 = Vector2.ZERO

@onready var pan_sprite : Sprite2D = $PanSprite
@onready var gold_sprite : Sprite2D = $PanSprite/GoldSprite
@onready var dirt_sprite = $PanSprite/DirtSprite

@onready var label : Label = $CanvasLayer/Control/Label

enum av_buttons {LEFT, RIGHT, UP, DOWN} #can add other buttons
var desired_button : av_buttons

var times_shaken : int = 0 # for testing
var times_to_shake : int = 3

var move_input : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_random_button():
	desired_button = av_buttons.keys()[randi() % av_buttons.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	button_tracker()
	
	move_input = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_just_pressed("Down") or Input.is_action_just_pressed("Up") or Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		times_shaken += 1
		if times_shaken >= times_to_shake:
			if dirt_sprite.frame + 1 < dirt_sprite.hframes * dirt_sprite.vframes:
				dirt_sprite.frame += 1
			
			times_shaken = 0
	
	
	
	pan_sprite.global_position = move_input * offset_dist

func button_tracker():
	match desired_button:
		av_buttons.LEFT:
			label.text = "PRESS LEFT"
		
		av_buttons.RIGHT:
			label.text = "PRESS RIGHT"
		
		av_buttons.UP:
			label.text = "PRESS UP"
		
		av_buttons.DOWN:
			label.text = "PRESS DOWN"
	
