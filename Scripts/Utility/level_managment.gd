extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	AudioPlayer.play_music_level()

@warning_ignore("unused_parameter")
func _process(delta):
	animation_player.play("background_final")
