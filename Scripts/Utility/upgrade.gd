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
	SignalManager.upgrade_sword.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_axe_upgrade_button_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_axe)
	SignalManager.upgrade_axe.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_spear_upgrade_button_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_spear)
	SignalManager.upgrade_spear.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()

func _on_health_upgrade_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_health)
	SignalManager.upgrade_health.emit()
	SignalManager.exp_sub.emit()
	set_text()
	check_exp()
	
func set_text():
	sword_upgrade_button.text = "Sword Lvl. " + str(Global.level_sword)
	axe_upgrade_button.text = "Axe Lvl. " + str(Global.level_axe)
	spear_upgrade_button.text = "Spear Lvl. " + str(Global.level_spear)
	health_upgrade_button.text = "Health Lvl. " + str(Global.level_health)
	Exp.text = "Exp: " + str(Global.current_exp_count)
	
func check_exp():
	if Global.current_exp_count <= 0:
		sword_upgrade_button.disabled = true
		axe_upgrade_button.disabled = true
		spear_upgrade_button.disabled = true
		health_upgrade_button.disabled = true
		continue_button.disabled = false

func _on_continue_button_pressed():
	AudioPlayer.play_FX(GlobalAudioSx.continue_pressed)
	foreground_animation_player.play("stand_up")
	await foreground_animation_player.animation_finished
	AudioPlayer.play_FX(GlobalAudioSx.upgrade_transition)
	SceneTransition.change_scene_restart()
