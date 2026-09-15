extends AudioStreamPlayer

@export var slow_song : AudioStream
@export var fast_song : AudioStream

var playing_slow : bool = false
var playing_fast : bool = false 

func _ready():
	if not playing: play_slow_song()

func play_slow_song():
	stop()
	stream = slow_song
	play()
	
	playing_slow = true
	playing_fast = false

func play_fast_song():
	stop()
	stream = fast_song
	play()
	
	playing_fast = true
	playing_slow = false

func player_song(song: AudioStream):
	stop()
	stream = song
	play()
