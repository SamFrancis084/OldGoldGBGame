extends CharacterBody2D

@export var SPD = 10000
@export var tileSize = 12
@export var animSPD = 0.35
@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D
var moving = false
var input_dir

@export_category("Audio") #footsteps
@export var default_step : AudioStream
@export var rock_step : AudioStream
@export var water_step : AudioStream

@export var step_rate : float = 0.45
var step_timer : float = 0.0

@export var footstep_tile_map : TileMapLayer
var rock_id : int = 0
var water_id : int = 1

func _physics_process(delta: float) -> void:
	
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("Down"):
		input_dir = Vector2(0,1)
		animSprite.play("walk_down")
	elif Input.is_action_pressed("Up"):
		input_dir = Vector2(0,-1)
		animSprite.play("walk_up")
	elif Input.is_action_pressed("Right"):
		input_dir = Vector2(1,0)
		animSprite.play("walk_right")
	elif Input.is_action_pressed("Left"):
		input_dir = Vector2(-1,0)
		animSprite.play("walk_left")
	
	move(delta)
	velocity = input_dir*SPD*delta
	move_and_slide()
	footstep_audio(delta)

func move(delta):
	
	if input_dir:
		if moving == false:
			moving == true
			#sam has annoyingly commented out this section for testing
			#var tween = create_tween()
			#tween.tween_property(self, "position", position + input_dir*tileSize, animSPD)
			#
			#tween.tween_callback(move_false)

func footstep_audio(delta):
	var step_clip : AudioStream = default_step
	
	if footstep_tile_map:
		var local = footstep_tile_map.to_local(global_position)
		var tile_pos = footstep_tile_map.local_to_map(local)
		
		var source_id = footstep_tile_map.get_cell_source_id(tile_pos)
		match source_id:
			rock_id:
				step_clip = rock_step
			water_id:
				step_clip = water_step
		print(source_id)
	
	step_timer -= delta
	if input_dir:
		if step_timer <= 0.0:
			AudioTools.PlayClip(step_clip, 0, 1, true)
			step_timer = step_rate

func move_false():
	moving = false
	
