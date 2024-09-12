extends Node2D

@onready var animation_player = $AnimationPlayer

func _process(delta):
	animation_player.play("background_final")
