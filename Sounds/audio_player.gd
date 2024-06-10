extends AudioStreamPlayer

const bg_music = preload("res://Sounds/Try_Hit_Me__Menu_Theme.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_bg():
	if (stream_paused == true):
		stream_paused = false
	_play_music(bg_music)

func stop_music_bg():
	stream_paused = true
