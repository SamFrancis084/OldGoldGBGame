extends Control

@export var typeSPD = 0.1
@export var string_array: Array[String]
@export var i = 0
@export var wait_time  = 0.0
@export var pause_time = 0.0
func _ready():
	
	show_word()
	


func _process(delta):
	
	if $RichTextLabel.visible_ratio <1:
		$RichTextLabel.visible_ratio+=typeSPD*delta
		$RichTextLabel.visible_ratio = min($RichTextLabel.visible_ratio, 1.0)
		wait_time += delta
		return
		
	if wait_time >= 1.0:
		
		pause_time += delta
		
	if pause_time > wait_time:
		i += 1
		pause_time = 0.0
		if i >= string_array.size():
			#$RichTextLabel.text = ""
			return
		else:
			show_word()
		
		

func show_word():
	$RichTextLabel.text = string_array[i]
	$RichTextLabel.visible_ratio = 0.0
	wait_time = 0.0
