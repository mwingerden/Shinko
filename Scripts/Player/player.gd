extends CharacterBody2D

@onready var progress_bar = $Health
@export var MAX_HEALTH = 20
var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_progress_bar()
		_play_animation()
		
func _update_progress_bar():
	progress_bar.value = (float(current_health) / MAX_HEALTH) * 100
	
func _play_animation():
	pass

func take_damage(value):
	current_health -= value
