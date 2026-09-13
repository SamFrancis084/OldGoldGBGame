extends Node2D

@export var offset_dist : float = 100.0
var start_pos : Vector2 = Vector2.ZERO

@onready var pan_sprite : Sprite2D = $PanSprite
@onready var gold_sprite : Sprite2D = $PanSprite/GoldSprite
@onready var dirt_sprite = $PanSprite/DirtSprite

@onready var label : Label = $CanvasLayer/Control/Label
@onready var attempt_label = $CanvasLayer/Control/AttemptLabel
@onready var time_left = $CanvasLayer/Control/TimeLeft


enum av_buttons {LEFT, RIGHT, UP, DOWN} #can add other buttons
var desired_button : av_buttons
var desired_string : String = "" #this has to match the input names

var times_shaken : int = 0 # for testing
var times_to_shake : int = 3
var max_frames : int = 0
var has_won : bool = false
@export var victory_screen : Control

@export_category("Lose State")
@export var max_wrong_attempts : int = 5
@export var max_time : float = 10.0
var timer : float 
var wrong_attempts : int = 0
var has_lost : bool = false

var move_input : Vector2 = Vector2.ZERO

@export_category("Audio")
@export var sift_stream : AudioStream
@export var timer_stream : AudioStream
var interval : float = 1.0
var tick_timer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = max_time
	victory_screen.visible = false
	get_random_button()
	max_frames = dirt_sprite.hframes * dirt_sprite.vframes

func get_random_button():
	desired_button = av_buttons.values().pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_won or has_lost: return
	
	button_tracker()
	
	move_input = Input.get_vector("Left", "Right", "Up", "Down")
	pan_sprite.global_position = move_input * offset_dist
	
	attempt_label.text = "Attempts Left: " + str(max_wrong_attempts - wrong_attempts)
	
	#for ticking
	tick_timer += delta
	if tick_timer >= interval:
		AudioTools.PlayClip(timer_stream)
		tick_timer = 0.0
	
	timer -= delta
	if timer < 0:
		has_lost = true
		lose()
	
	time_left.text = "Time Left: " + str(roundf(timer * 10) / 10)

func _input(event):
	
	if has_won or has_lost:
		if event.is_pressed() and not event.is_echo():
			get_tree().reload_current_scene() # go back to walking around
		
		return
	
	if event.is_pressed() and not event.is_echo():
		if Input.is_action_just_pressed(desired_string):
			times_shaken += 1
			
			if times_shaken >= times_to_shake:
				if dirt_sprite.frame + 1 < max_frames:
					dirt_sprite.frame += 1
				else:
					dirt_sprite.visible = false
					has_won = true
					win()
					return
				
				times_shaken = 0
			
		else: #you pressed the wrong button
			print("You pressed the wrong thang bucko")
			wrong_attempts += 1
			if wrong_attempts >= max_wrong_attempts:
				lose()
				has_lost = true
		
		if sift_stream: AudioTools.PlayClip(sift_stream, 0.0, 1.0, true)
		get_random_button()

func button_tracker():
	match desired_button:
		av_buttons.LEFT:
			label.text = "PRESS LEFT"
			desired_string = "Left"
		
		av_buttons.RIGHT:
			label.text = "PRESS RIGHT"
			desired_string = "Right"
		
		av_buttons.UP:
			label.text = "PRESS UP"
			desired_string = "Up"
		
		av_buttons.DOWN:
			label.text = "PRESS DOWN"
			desired_string = "Down"
	

func win():
	if victory_screen: victory_screen.visible = true

func lose():
	get_tree().reload_current_scene()
