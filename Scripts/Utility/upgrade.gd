extends Node2D

@onready var sword_upgrade_button = $SwordUpgradeButton
@onready var axe_upgrade_button = $AxeUpgradeButton
@onready var spear_upgrade_button = $SpearUpgradeButton
@onready var health_upgrade_button = $HealthUpgradeButton
@onready var continue_button = $ContinueButton
@onready var Exp = $Exp
@onready var background_animation_player = $Background_Animation
@onready var foreground_animation_player = $Foreground_Animation

func _ready():
	continue_button.disabled = true
	set_text()
	check_exp()

@warning_ignore("unused_parameter")
func _process(delta):
	background_animation_player.play("background")

func _on_sword_upgrade_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_sword)
	SignalManager.exp_sub_weapon.emit(Global.sword_crit)
	SignalManager.upgrade_sword.emit(Global.sword_crit)
	set_text()
	check_exp()

func _on_axe_upgrade_button_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_axe)
	SignalManager.exp_sub_weapon.emit(Global.axe_crit)
	SignalManager.upgrade_axe.emit(Global.axe_crit)
	set_text()
	check_exp()

func _on_spear_upgrade_button_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_spear)
	SignalManager.exp_sub_weapon.emit(Global.spear_crit)
	SignalManager.upgrade_spear.emit(Global.spear_crit)
	set_text()
	check_exp()

func _on_health_upgrade_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_health)
	SignalManager.exp_sub_health.emit(Global.level_health)
	SignalManager.upgrade_health.emit()
	set_text()
	check_exp()
	
func set_text():
	sword_upgrade_button.text = "Sword Crit Chance: " + str(Global.sword_crit) + "%"
	axe_upgrade_button.text = "Axe Crit Chance: " + str(Global.axe_crit) + "%"
	spear_upgrade_button.text = "Spear Crit Chance: " + str(Global.spear_crit) + "%"
	health_upgrade_button.text = "Extra Health: +" + str(Global.level_health)
	Exp.text = "Exp: " + str(Global.current_exp_count)
	
func check_exp():
	if Global.current_exp_count <= 0:
		sword_upgrade_button.disabled = true
		axe_upgrade_button.disabled = true
		spear_upgrade_button.disabled = true
		health_upgrade_button.disabled = true
		continue_button.disabled = false
	
	if Global.sword_crit == 0:
		if Global.current_exp_count < 1:
			sword_upgrade_button.disabled = true
	elif Global.sword_crit == 5:
		if Global.current_exp_count < 3:
			sword_upgrade_button.disabled = true
	elif Global.sword_crit == 10:
		if Global.current_exp_count < 5:
			sword_upgrade_button.disabled = true
	elif Global.sword_crit == 15:
		if Global.current_exp_count < 7:
			sword_upgrade_button.disabled = true
	elif Global.sword_crit == 20:
		if Global.current_exp_count < 10:
			sword_upgrade_button.disabled = true
	elif Global.sword_crit == 25:
		sword_upgrade_button.disabled = true
	
	if Global.axe_crit == 0:
		if Global.current_exp_count < 1:
			axe_upgrade_button.disabled = true
	elif Global.axe_crit == 5:
		if Global.current_exp_count < 3:
			axe_upgrade_button.disabled = true
	elif Global.axe_crit == 10:
		if Global.current_exp_count < 5:
			axe_upgrade_button.disabled = true
	elif Global.axe_crit == 15:
		if Global.current_exp_count < 7:
			axe_upgrade_button.disabled = true
	elif Global.axe_crit == 20:
		if Global.current_exp_count < 10:
			axe_upgrade_button.disabled = true
	elif Global.axe_crit == 25:
		axe_upgrade_button.disabled = true
	
	if Global.spear_crit == 0:
		if Global.current_exp_count < 1:
			spear_upgrade_button.disabled = true
	elif Global.spear_crit == 5:
		if Global.current_exp_count < 3:
			spear_upgrade_button.disabled = true
	elif Global.spear_crit == 10:
		if Global.current_exp_count < 5:
			spear_upgrade_button.disabled = true
	elif Global.spear_crit == 15:
		if Global.current_exp_count < 7:
			spear_upgrade_button.disabled = true
	elif Global.spear_crit == 20:
		if Global.current_exp_count < 10:
			spear_upgrade_button.disabled = true
	elif Global.spear_crit == 25:
		spear_upgrade_button.disabled = true
	
	if Global.level_health >= 0 and Global.level_health < 5:
		if Global.current_exp_count < 1:
			health_upgrade_button.disabled = true
	elif Global.level_health >= 5 and Global.level_health < 10:
		if Global.current_exp_count < 2:
			health_upgrade_button.disabled = true
	elif Global.level_health >= 10 and Global.level_health < 15:
		if Global.current_exp_count < 3:
			health_upgrade_button.disabled = true
	elif Global.level_health >= 15 and Global.level_health < 20:
		if Global.current_exp_count < 4:
			health_upgrade_button.disabled = true
	elif Global.level_health >= 20:
		if Global.current_exp_count < 5:
			health_upgrade_button.disabled = true

func _on_continue_button_pressed():
	continue_button.disabled = true
	AudioPlayer.play_FX(GlobalAudioSx.continue_pressed)
	foreground_animation_player.play("stand_up")
	await foreground_animation_player.animation_finished
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_transition)
	SceneTransition.change_scene_restart()
