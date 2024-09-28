extends Node

var starting_exp = 0
var current_exp_count = starting_exp
var health_potion_count = 1
var shield_potion_count = 1
var player_current_weapon = 0
enum weapon {SWORD, AXE, SPEAR}
var level_sword = 0
var level_axe = 0
var level_spear = 0
var sword_crit = 0
var axe_crit = 0
var spear_crit = 0
var level_health = 0
var PLAYER_STARTING_HEALTH = 10
var MAX_PLAYER_HEALTH = 10
var MAX_PLAYER_SHIELD = 10
var heal_amount = 1
var increase_shield_amount = 5
var shield_on = false
var player_age = 10
var player_current_health = MAX_PLAYER_HEALTH
var player_current_shield = 0
var STARTING_ENEMY_DAMAGE = 1
var enemy_damage = STARTING_ENEMY_DAMAGE

func _ready():
	SignalManager.upgrade_sword.connect(upgrade_sword)
	SignalManager.upgrade_axe.connect(upgrade_axe)
	SignalManager.upgrade_spear.connect(upgrade_spear)
	SignalManager.upgrade_health.connect(upgrade_health)
	SignalManager.exp_add.connect(exp_add)
	SignalManager.exp_sub_weapon.connect(exp_sub_weapon)
	SignalManager.exp_sub_health.connect(exp_sub_health)
	SignalManager.age_up.connect(age_up)
	SignalManager.player_restart.connect(player_restart)
	
func upgrade_sword(current_level):
	level_sword += 1
	if current_level == 0:
		sword_crit = 5
	elif current_level == 5:
		sword_crit = 10
	elif current_level == 10:
		sword_crit = 15
	elif current_level == 15:
		sword_crit = 20
	elif current_level == 20:
		sword_crit = 25
	
func upgrade_axe(current_level):
	level_axe += 1
	if current_level == 0:
		axe_crit = 5
	elif current_level == 5:
		axe_crit = 10
	elif current_level == 10:
		axe_crit = 15
	elif current_level == 15:
		axe_crit = 20
	elif current_level == 20:
		axe_crit = 25
	
func upgrade_spear(current_level):
	level_spear += 1
	if current_level == 0:
		spear_crit = 5
	elif current_level == 5:
		spear_crit = 10
	elif current_level == 10:
		spear_crit = 15
	elif current_level == 15:
		spear_crit = 20
	elif current_level == 20:
		spear_crit = 25
	
func upgrade_health():
	level_health += 1
	MAX_PLAYER_HEALTH += 1
	
func exp_add(value):
	current_exp_count += value
	
func exp_sub_weapon(current_level):
	if current_level == 0:
		if !(current_exp_count - 1 < 0):
			current_exp_count -= 1
	elif current_level == 5:
		if !(current_exp_count - 3 < 0):
			current_exp_count -= 3
	elif current_level == 10:
		if !(current_exp_count - 5 < 0):
			current_exp_count -= 5
	elif current_level == 15:
		if !(current_exp_count - 7 < 0):
			current_exp_count -= 7
	elif current_level == 20:
		if !(current_exp_count - 10 < 0):
			current_exp_count -= 10

func exp_sub_health(current_level):
	if current_level >= 0 and current_level < 5:
		current_exp_count -= 1
	elif current_level >= 5 and current_level < 10:
		current_exp_count -= 2
	elif current_level >= 10 and current_level < 15:
		current_exp_count -= 3
	elif current_level >= 15 and current_level < 20:
		current_exp_count -= 4
	elif level_health >= 20:
		current_exp_count -= 5

func age_up():
	player_age += 1
	#print("Player is age: " + str(player_age))

func player_restart():
	Global.player_current_health = Global.MAX_PLAYER_HEALTH + Global.level_health
	#print(Global.player_current_health)
	Global.player_current_shield = 0
	Global.current_exp_count = Global.starting_exp
	enemy_damage = STARTING_ENEMY_DAMAGE
