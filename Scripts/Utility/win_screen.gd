extends Node2D

@onready var sparkle = $AnimationPlayer
@onready var door = $AnimationPlayer2

func _ready():
	sparkle.play("sparkle'")
	door.play("door_open")

func _on_main_menu_pressed():
	LevelManager.main_menu()

func _on_end_pressed():
	SceneTransition.quit_game()
