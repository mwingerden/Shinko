extends CharacterBody2D

@onready var health_progress_bar = $Health
@onready var shield_progress_bar = $Shield
@onready var animation_player = $AnimationPlayer
@export var MAX_HEALTH = 20
@export var MAX_SHIELD = 10
@export var heal_amount = 1
@export var increase_shield_amount = 1
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

func _ready():
	Global.player_current_weapon = Global.weapon.SWORD
	SignalManager.weapon_swap.connect(swap_weapon)
	SignalManager.player_take_damage.connect(take_damage)
	SignalManager.player_increase_health.connect(heal)
	SignalManager.player_increase_shield.connect(increase_shield)
	show_health_bar(true)

@warning_ignore("unused_parameter")
func _process(delta):
	_play_animation()

func show_health_bar(value):
	health_progress_bar.visible = value
	shield_progress_bar.visible = !value
	shield_on = !value

func swap_weapon():
	if Global.player_current_weapon == Global.weapon.SWORD:
		#current_weapon = weapon.AXE
		Global.player_current_weapon = Global.weapon.AXE
		#print("Switched to Spear")
	elif Global.player_current_weapon == Global.weapon.AXE:
		#current_weapon = weapon.SPEAR
		Global.player_current_weapon = Global.weapon.SPEAR
		#print("Switched to Sword")
	elif Global.player_current_weapon == Global.weapon.SPEAR:
		#current_weapon = weapon.SWORD
		Global.player_current_weapon = Global.weapon.SWORD
		#print("Switched to Axe")

func _update_health_bar():
	health_progress_bar.value = (float(current_health) / MAX_HEALTH) * 100

func _update_shield_bar():
	shield_progress_bar.value = (float(current_shield) / MAX_SHIELD) * 100
	
func _play_animation():
	if Global.player_current_weapon == Global.weapon.SWORD:
		animation_player.play("sword")
	elif Global.player_current_weapon == Global.weapon.AXE:
		animation_player.play("axe")
	elif Global.player_current_weapon == Global.weapon.SPEAR:
		animation_player.play("spear")

func take_damage(value):
	if shield_on:
		current_shield -= float(value) / 2.0
		if current_shield <= 0:
			current_shield = 0
			show_health_bar(true)
	else:
		current_health -= value
	
#func get_current_weapon():
	#return current_weapon
	
func increase_shield():
	if current_shield <= MAX_SHIELD:
		current_shield += increase_shield_amount
	show_health_bar(false)
	
func heal():
	if current_health <= MAX_HEALTH:
		current_health += heal_amount
