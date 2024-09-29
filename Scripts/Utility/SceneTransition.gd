extends CanvasLayer

@onready var animation = $AnimationPlayer

func start_game():
	animation.play_backwards("dissolve")
	await animation.animation_finished

func change_scene(target):
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("dissolve")

func change_scene_death():
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menus/upgrade.tscn")
	animation.play_backwards("dissolve")
	
func change_scene_restart():
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	animation.play_backwards("dissolve")
	
func game_lose():
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menus/game_over_screen.tscn")
	animation.play_backwards("dissolve")

func quit_game():
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().quit()
