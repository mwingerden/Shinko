extends AudioStreamPlayer2D

const level_music = preload("res://Assets/Music/OST/Shinko Track WAVE.wav")

func _player_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_level():
	_player_music(level_music)
