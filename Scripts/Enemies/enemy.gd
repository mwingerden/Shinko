extends CharacterBody2D

@onready var selected = $Selected
@onready var progress_bar = $Health
@onready var animation_player = $AnimationPlayer

@export var MAX_HEALTH = 5

var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_progress_bar()
		_play_animation()
		
func _update_progress_bar():
	progress_bar.value = (current_health/MAX_HEALTH) * 100
	
func _play_animation():
	pass
	
func _selected():
	selected.show()
	
func _unselect():
	selected.hide()
