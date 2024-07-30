extends Node2D

@onready var sword_upgrade_button = $SwordUpgradeButton
@onready var axe_upgrade_button = $AxeUpgradeButton
@onready var spear_upgrade_button = $SpearUpgradeButton
@onready var health_upgrade_button = $HealthUpgradeButton
@onready var continue_button = $ContinueButton
@onready var Exp = $Exp

func _ready():
	continue_button.disabled = true
	set_text()
	check_exp()

func _on_sword_upgrade_pressed():
	SignalManager.upgrade_sword.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_axe_upgrade_button_pressed():
	SignalManager.upgrade_axe.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_spear_upgrade_button_pressed():
	SignalManager.upgrade_spear.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_health_upgrade_pressed():
	SignalManager.upgrade_sword.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()
	
func set_text():
	sword_upgrade_button.text = "Sword Lvl. " + str(Global.level_sword)
	axe_upgrade_button.text = "Axe Lvl. " + str(Global.level_axe)
	spear_upgrade_button.text = "Spear Lvl. " + str(Global.level_spear)
	health_upgrade_button.text = "Health Lvl. " + str(Global.level_sword)
	Exp.text = "Exp: " + str(Global.current_exp_count)
	
func check_exp():
	if Global.current_exp_count <= 0:
		sword_upgrade_button.disabled = true
		axe_upgrade_button.disabled = true
		spear_upgrade_button.disabled = true
		health_upgrade_button.disabled = true
		continue_button.disabled = false

func _on_continue_button_pressed():
	SceneTransition.change_scene("res://Scenes/Levels/level_1.tscn")
