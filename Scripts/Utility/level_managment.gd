extends Node2D

@onready var animation_player = $AnimationPlayer

@warning_ignore("unused_parameter")
func _process(delta):
	animation_player.play("background_final")
