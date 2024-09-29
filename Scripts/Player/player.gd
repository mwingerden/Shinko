extends CharacterBody2D

@onready var health_progress_bar = $Health
@onready var shield_progress_bar = $Shield
@onready var animation_player = $AnimationPlayer
@onready var sprite_player = $Sprite2D

func _ready():
	Global.player_current_weapon = Global.weapon.SWORD
	SignalManager.weapon_swap.connect(swap_weapon)
	SignalManager.player_take_damage.connect(take_damage)
	SignalManager.player_increase_health.connect(heal)
	SignalManager.player_increase_shield.connect(increase_shield)
	SignalManager.update_player_bars.connect(update_player_bars)
	SignalManager.player_attack.connect(player_attack)
	SignalManager.player_hurt.connect(player_hurt)
	update_player_bars()
	if Global.shield_on:
		show_health_bar(false)
	else:
		show_health_bar(true)

@warning_ignore("unused_parameter")
func _process(delta):
	_play_animation()

func update_player_bars():
	_update_health_bar()
	_update_shield_bar()

func show_health_bar(value):
	health_progress_bar.visible = value
	shield_progress_bar.visible = !value
	Global.shield_on = !value

func swap_weapon():
	if Global.player_current_weapon == Global.weapon.SWORD:
		#current_weapon = weapon.AXE
		AudioPlayer.play_FX(GlobalAudioSx.axe_switch)
		Global.player_current_weapon = Global.weapon.AXE
		#print("Switched to Spear")
	elif Global.player_current_weapon == Global.weapon.AXE:
		#current_weapon = weapon.SPEAR
		AudioPlayer.play_FX(GlobalAudioSx.spear_switch)
		Global.player_current_weapon = Global.weapon.SPEAR
		#print("Switched to Sword")
	elif Global.player_current_weapon == Global.weapon.SPEAR:
		#current_weapon = weapon.SWORD
		AudioPlayer.play_FX(GlobalAudioSx.sword_switch)
		Global.player_current_weapon = Global.weapon.SWORD
		#print("Switched to Axe")

func _update_health_bar():
	health_progress_bar.max_value = Global.MAX_PLAYER_HEALTH * 10
	health_progress_bar.value = (float(Global.player_current_health) / Global.MAX_PLAYER_HEALTH) * 100
	print("Player level health: " + str(Global.level_health) + "\n")
	print("Player Health: " + str(health_progress_bar.value) + "\n")

func _update_shield_bar():
	shield_progress_bar.value = (float(Global.player_current_shield) / Global.MAX_PLAYER_SHIELD) * 100
	
func _play_animation():
	if Global.player_current_weapon == Global.weapon.SWORD:
		if Global.player_age >=10 and Global.player_age < 30:
			animation_player.play("sword_one")
		elif Global.player_age >=30 and Global.player_age < 50:
			animation_player.play("sword_two")
		elif Global.player_age >=50 and Global.player_age < 70:
			animation_player.play("sword_three")
		elif Global.player_age >=70 and Global.player_age < 100:
			animation_player.play("sword_four")
	elif Global.player_current_weapon == Global.weapon.AXE:
		if Global.player_age >=10 and Global.player_age < 30:
			animation_player.play("axe_one")
		elif Global.player_age >=30 and Global.player_age < 50:
			animation_player.play("axe_two")
		elif Global.player_age >=50 and Global.player_age < 70:
			animation_player.play("axe_three")
		elif Global.player_age >=70 and Global.player_age < 100:
			animation_player.play("axe_four")
		#animation_player.play("axe")
	elif Global.player_current_weapon == Global.weapon.SPEAR:
		if Global.player_age >=10 and Global.player_age < 30:
			animation_player.play("spear_one")
		elif Global.player_age >=30 and Global.player_age < 50:
			animation_player.play("spear_two")
		elif Global.player_age >=50 and Global.player_age < 70:
			animation_player.play("spear_three")
		elif Global.player_age >=70 and Global.player_age < 100:
			animation_player.play("spear_four")
		#animation_player.play("spear")

func player_attack():
	sprite_player.offset.x += 20
	await get_tree().create_timer(.3).timeout 
	sprite_player.offset.x -= 20

func player_hurt():
	sprite_player.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_player.visible = true
	await get_tree().create_timer(.05).timeout 
	sprite_player.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_player.visible = true
	await get_tree().create_timer(.05).timeout 
	sprite_player.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_player.visible = true

func take_damage(value):
	if Global.shield_on:
		Global.player_current_shield -= float(value) / 2.0
		if Global.player_current_shield <= 0:
			Global.player_current_shield = 0
			show_health_bar(true)
	else:
		Global.player_current_health -= value
	update_player_bars()
	if Global.player_current_health <= 0:
		SignalManager.player_death.emit()
	
func increase_shield():
	Global.player_current_shield += Global.increase_shield_amount
	if Global.player_current_shield > Global.MAX_PLAYER_SHIELD:
		Global.player_current_shield = Global.MAX_PLAYER_SHIELD
	show_health_bar(false)
	update_player_bars()
	
func heal():
	print("Player Current Health: " + str(Global.player_current_health) + "\n")
	Global.player_current_health += Global.MAX_PLAYER_HEALTH * .25
	if Global.player_current_health > Global.MAX_PLAYER_HEALTH:
		Global.player_current_health = Global.MAX_PLAYER_HEALTH
	print("Player Current Health: " + str(Global.player_current_health) + "\n")
	update_player_bars()
