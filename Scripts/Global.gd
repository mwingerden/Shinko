extends Node

var starting_exp = 0
var current_exp_count = starting_exp
var health_potion_count = 1
var shield_potion_count = 1
var player_current_weapon = 0
enum weapon {SWORD, AXE, SPEAR}
var level_sword = 1
var level_axe = 1
var level_spear = 1
var level_health = 0
var MAX_PLAYER_HEALTH = 10
var MAX_PLAYER_SHIELD = 10
var heal_amount = 1
var increase_shield_amount = 10
var shield_on = false
var player_age = 10
var player_current_health = MAX_PLAYER_HEALTH
var player_current_shield = 0

func _ready():
	SignalManager.upgrade_sword.connect(upgrade_sword)
	SignalManager.upgrade_axe.connect(upgrade_axe)
	SignalManager.upgrade_spear.connect(upgrade_spear)
	SignalManager.upgrade_health.connect(upgrade_health)
	SignalManager.exp_add.connect(exp_add)
	SignalManager.exp_sub.connect(exp_sub)
	SignalManager.age_up.connect(age_up)
	SignalManager.player_restart.connect(player_restart)
	
func upgrade_sword():
	level_sword += 1
	
func upgrade_axe():
	level_axe += 1
	
func upgrade_spear():
	level_spear += 1
	
func upgrade_health():
	level_health += 1
	
func exp_add(value):
	current_exp_count += value
	
func exp_sub():
	current_exp_count -= 1
	
func age_up():
	player_age += 1
	print("Player is not age: " + str(player_age))

func player_restart():
	Global.player_current_health = Global.MAX_PLAYER_HEALTH + Global.level_health
	#print(Global.player_current_health)
	Global.player_current_shield = 0
	Global.current_exp_count = Global.starting_exp
