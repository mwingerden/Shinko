extends CanvasLayer

@onready var animation = $AnimationPlayer

func change_scene(target):
	animation.play("dissolve")
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("dissolve")
