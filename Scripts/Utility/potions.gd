extends Node2D
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _process(delta):
	animation_player.play("play")
	pass
