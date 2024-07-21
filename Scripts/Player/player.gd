extends CharacterBody2D

@onready var progress_bar = $Health
@onready var animation_player = $AnimationPlayer
@export var MAX_HEALTH = 20
var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_progress_bar()
		_play_animation()
		
enum state {SWORD, AXE, SPEAR}
var current_state = state.SWORD

func _process(delta):
	_play_animation()

func swap_weapon():
	if current_state == state.SWORD:
		current_state = state.AXE
		#print("Switched to Spear")
	elif current_state == state.AXE:
		current_state = state.SPEAR
		#print("Switched to Sword")
	elif current_state == state.SPEAR:
		current_state = state.SWORD
		#print("Switched to Axe")

func _update_progress_bar():
	progress_bar.value = (float(current_health) / MAX_HEALTH) * 100
	
func _play_animation():
	if current_state == state.SWORD:
		animation_player.play("sword")
	elif current_state == state.AXE:
		animation_player.play("axe")
	elif current_state == state.SPEAR:
		animation_player.play("spear")

func take_damage(value):
	current_health -= value
	
func current_weapon():
	return current_state
