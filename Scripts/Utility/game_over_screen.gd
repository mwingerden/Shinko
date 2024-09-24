extends Node2D

func _ready():
	AudioPlayer.play_music_level()

func _on_restart_pressed():
	LevelManager.main_menu()

func _on_give_up_pressed():
	SceneTransition.quit_game()
