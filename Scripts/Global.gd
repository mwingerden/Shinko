extends Node

var exp_count = 1
var health_potion_count = 1
var shield_potion_count = 1
var player_current_weapon = 0
enum weapon {SWORD, AXE, SPEAR}
var level_sword = 1
var level_axe = 1
var level_spear = 1

func _ready():
	SignalManager.upgrade_sword.connect(upgrade_sword)
	SignalManager.upgrade_axe.connect(upgrade_axe)
	SignalManager.upgrade_spear.connect(upgrade_spear)
	SignalManager.upgrade_health.connect(upgrade_health)
	SignalManager.exp_add.connect(exp_add)
	SignalManager.exp_sub.connect(exp_sub)
	
func upgrade_sword():
	level_sword += 1
	
func upgrade_axe():
	level_axe += 1
	
func upgrade_spear():
	level_spear += 1
	
func upgrade_health():
	level_sword += 1
	
func exp_add():
	exp_count += 1
	
func exp_sub():
	exp_count -= 1
