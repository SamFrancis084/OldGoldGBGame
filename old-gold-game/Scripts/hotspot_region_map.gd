extends TileMapLayer

@export var hotspot_count : int = 10

@export var hotspot : PackedScene # the prefab
var hotspots : Array[Hotspot] # array of hotspots

var available_spots : Array[Vector2]

@export var teleport_time : float = 10.0
var teleport_timer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = get_used_cells()
	for cell in cells:
		var global_pos = map_to_local(cell)
		available_spots.append(global_pos)
	
	if available_spots.size() > 0:
		spawn_hotspots()

func spawn_hotspots():
	for i in range(hotspot_count):
		#spawn hotspot
		var new_hs = hotspot.instantiate()
		get_tree().current_scene.add_child.call_deferred(new_hs)
		hotspots.append(new_hs)
		
		#give initial position
		var pos : Vector2 = available_spots.pick_random()
		new_hs.global_position = to_global(pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	teleport_timer += delta
	
	if teleport_timer > teleport_time:
		teleport_hotspots()
		teleport_timer = 0.0

func teleport_hotspots():
	if hotspots.size() <= 0: return
	
	for hs in hotspots:
		var pos : Vector2 = available_spots.pick_random()
		hs.global_position = to_global(pos)
