extends Node2D

func _ready():
	SceneTransition.start_game()
	AudioPlayer.play_music_level()

func _on_start_pressed():
	LevelManager.start()

func _on_credits_pressed():
	LevelManager.credits()

func _on_exit_pressed():
	SceneTransition.quit_game()
