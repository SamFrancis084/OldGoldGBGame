extends Control

@export var typeSPD = 0.1
@export var string_array: Array[String]
@export var i = 0
var wait_time  = 0.0
func _ready():
	
	show_word()


func _process(delta):
	
	if $RichTextLabel.visible_ratio <1:
		$RichTextLabel.visible_ratio+=typeSPD*delta
		$RichTextLabel.visible_ratio = min($RichTextLabel.visible_ratio, 1.0)
		return
		wait_time += delta
		
		if wait_time >= 1.0:
			i += 1
		
			if i >= string_array.size():
				return
			else:
				show_word()
		

func show_word():
	$RichTextLabel.text = string_array[i]
	$RichTextLabel.visible_ratio = 0.0
	wait_time = 0.0
	
