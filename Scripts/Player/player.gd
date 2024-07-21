extends CharacterBody2D

@onready var health_progress_bar = $Health
@onready var shield_progress_bar = $Shield
@onready var animation_player = $AnimationPlayer
@export var MAX_HEALTH = 20
@export var MAX_SHIELD = 10
var shield_on = false
var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_health_bar()
		_play_animation()
var current_shield = 0:
	set(value):
		current_shield = value
		_update_shield_bar()
		_play_animation()
enum state {SWORD, AXE, SPEAR}
var current_state = state.SWORD

func _ready():
	show_health_bar(true)

func _process(delta):
	_play_animation()

func show_health_bar(value):
	health_progress_bar.visible = value
	shield_progress_bar.visible = !value

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

func _update_health_bar():
	health_progress_bar.value = (float(current_health) / MAX_HEALTH) * 100

func _update_shield_bar():
	shield_progress_bar.value = (float(current_shield) / MAX_SHIELD) * 100
	
func _play_animation():
	if current_state == state.SWORD:
		animation_player.play("sword")
	elif current_state == state.AXE:
		animation_player.play("axe")
	elif current_state == state.SPEAR:
		animation_player.play("spear")

func take_damage(value):
	if shield_on:
		current_shield -= float(value) / 2.0
	else:
		current_health -= value
	
func current_weapon():
	return current_state
	
func increase_shield():
	shield_on = true
	if current_shield <= MAX_SHIELD:
		current_shield += 1
	show_health_bar(false)
