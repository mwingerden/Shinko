extends CharacterBody2D

@onready var selected_sprite = $Selected
@onready var progress_bar = $Health
@onready var animation_player = $AnimationPlayer
var selected = false
var weapon = "axe"

@export var MAX_HEALTH = 2
var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_progress_bar()
		_play_animation()
		
func _update_progress_bar():
	progress_bar.value = (float(current_health) / MAX_HEALTH) * 100
	
func _play_animation():
	pass
	
func _select():
	selected_sprite.show()
	selected = true
	
func _unselect():
	selected_sprite.hide()
	selected = false
	
func is_selected():
	return selected
	
func take_damage(value):
	current_health = max(0, current_health - value)

func get_current_health():
	return current_health
	
func get_weapon_type():
	return weapon
