extends CharacterBody2D

@onready var health_progress_bar = $Health
@onready var shield_progress_bar = $Shield
@onready var animation_player = $AnimationPlayer


func _ready():
	Global.player_current_weapon = Global.weapon.SWORD
	SignalManager.weapon_swap.connect(swap_weapon)
	SignalManager.player_take_damage.connect(take_damage)
	SignalManager.player_increase_health.connect(heal)
	SignalManager.player_increase_shield.connect(increase_shield)
	SignalManager.player_restart.connect(player_restart)
	show_health_bar(true)

@warning_ignore("unused_parameter")
func _process(delta):
	_play_animation()

func player_restart():
	Global.player_current_health = Global.MAX_PLAYER_HEALTH
	Global.player_current_shield = 0
	Global.current_exp_count = Global.starting_exp
	_update_health_bar()
	_update_shield_bar()

func show_health_bar(value):
	health_progress_bar.visible = value
	shield_progress_bar.visible = !value
	Global.shield_on = !value

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
	health_progress_bar.value = (float(Global.player_current_health) / Global.MAX_PLAYER_HEALTH) * 100

func _update_shield_bar():
	shield_progress_bar.value = (float(Global.player_current_shield) / Global.MAX_PLAYER_SHIELD) * 100
	
func _play_animation():
	if Global.player_current_weapon == Global.weapon.SWORD:
		animation_player.play("sword")
	elif Global.player_current_weapon == Global.weapon.AXE:
		animation_player.play("axe")
	elif Global.player_current_weapon == Global.weapon.SPEAR:
		animation_player.play("spear")

func take_damage(value):
	if Global.shield_on:
		Global.current_shield -= float(value) / 2.0
		if Global.current_shield <= 0:
			Global.current_shield = 0
			show_health_bar(true)
	else:
		Global.player_current_health -= value
	_update_health_bar()
	if Global.player_current_health <= 0:
		SignalManager.player_death.emit()
	
func increase_shield():
	if Global.current_shield <= Global.MAX_PLAYER_SHIELD:
		Global.current_shield += Global.increase_shield_amount
	show_health_bar(false)
	_update_shield_bar()
	
func heal():
	if Global.current_health <= Global.MAX_PLAYER_HEALTH:
		Global.current_health += Global.heal_amount
		_update_health_bar()
