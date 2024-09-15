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
	
func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	await fx_player.finished
	fx_player.queue_free()
