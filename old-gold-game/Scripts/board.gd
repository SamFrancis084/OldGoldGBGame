extends Node2D

@export var sprite_array : Array[Sprite2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	init_board()

func init_board():
	if sprite_array and sprite_array.size() > 0:
		for i in range(sprite_array.size() - 1):
			if ItemHolder.item_list.size() > i and ItemHolder.item_list[i]:
				var item = ItemHolder.item_list[i]
				var tex = item.sprite
				sprite_array[i].texture = tex
				
				#do silhoutte stuff
				var mat : ShaderMaterial = sprite_array[i].material
				mat.set_shader_parameter("active", ItemHolder.item_list[i].unlocked)
			else:
				sprite_array[i].texture = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
