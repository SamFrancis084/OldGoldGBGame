extends CharacterBody2D

@export var SPD = 10000
@export var tileSize = 12
@export var animSPD = 0.35
@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D
var moving = false
var input_dir

func _physics_process(delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		input_dir = Vector2(0,1)
		animSprite.play("walk_down")
		move()
	elif Input.is_action_pressed("ui_up"):
		input_dir = Vector2(0,-1)
		animSprite.play("walk_up")
		move()
	elif Input.is_action_pressed("ui_right"):
		input_dir = Vector2(1,0)
		animSprite.play("walk_right")
		move()
	elif Input.is_action_pressed("ui_left"):
		input_dir = Vector2(-1,0)
		animSprite.play("walk_left")
		move()
	velocity = input_dir*SPD*delta
	move_and_slide()

func move():
	if input_dir:
		if moving == false:
			moving == true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tileSize, animSPD)
			
			tween.tween_callback(move_false)

func move_false():
	moving = false
	
