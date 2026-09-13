extends Node


func PlayClip(stream : AudioStream, volume : float = 0.0, pitch : float = 1.0, random_pitch : bool = false):
	if is_instance_valid(get_tree().current_scene) == false: return
	
	var stream_player := AudioStreamPlayer.new()
	
	get_tree().current_scene.add_child(stream_player)
	stream_player.finished.connect(stream_player.queue_free)
	
	stream_player.stream = stream
	stream_player.volume_db = volume
	stream_player.pitch_scale = pitch
	if random_pitch: stream_player.pitch_scale = randf_range(pitch - 0.2, pitch + 0.2)
	
	stream_player.play()
