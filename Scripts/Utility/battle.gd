extends Node2D

var rng = RandomNumberGenerator.new()
var enemies = []
var action_queue = []
var is_battling = false
var index = 0
var enemy_turn = false
enum attack_type {NUETRAL, CRIT, RESIST}
var current_attack_type = attack_type.NUETRAL
var damage
var potion
var defend = false
var potion_spawn = false
@onready var actions_menu = $"../Actions"
@onready var item_menu = $"../Items"
var health_potion = preload("res://Scenes/Utility/potion_health.tscn")
var shield_potion = preload("res://Scenes/Utility/potion_shield.tscn")
@onready var shield_potion_button = $"../Items/Panel/HBoxContainer/Shield"
@onready var health_potion_button = $"../Items/Panel/HBoxContainer/Health"

func _ready():
	enemies = find_children("Enemy*")
	enemies[0]._select()
	#player = get_child(0)
	show_actions_menu(true)
	SignalManager.player_death.connect(player_death)
	
@warning_ignore("unused_parameter")
func _process(delta):
	if !enemy_turn and Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
			switch_focus(index, index + 1)
	elif !enemy_turn and Input.is_action_just_pressed("ui_down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(index, index - 1)
			
	if enemies.size() <= 0:
		await get_tree().create_timer(.5).timeout
		get_tree().quit()
	
	health_potion_button.set_text(str(Global.health_potion_count)+ " Health Potions")
	shield_potion_button.set_text(str(Global.shield_potion_count) + " Shield Potions")

func switch_focus(x,y):
	enemies[x]._select()
	enemies[y]._unselect()

func _on_attack_pressed():
	disable_buttons(true)
	for i in enemies.size():
		if enemies[i].is_selected():
			damage = 1
			if enemies[i].get_weapon_type() == "axe" and Global.player_current_weapon == 0:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "spear" and Global.player_current_weapon == 1:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "sword" and Global.player_current_weapon == 2:
				damage = damage * 2
			enemies[i].take_damage(damage)
			if enemies[i].get_current_health() <= 0:
				#Play Death Animation Here
				SignalManager.exp_add.emit()
				spawn_potion(enemies[i].global_position)
				enemies[i].queue_free()
				enemies.remove_at(i)
				if enemies.size() > 0:
					enemies[0]._select()
					index = 0
			else:
				await get_tree().create_timer(.5).timeout
			break
	enemies_turn()
	
func enemies_turn():
	enemy_turn = true
	for i in enemies.size():
		#Perform Attck Animation
		damage = 1
		if !defend:
			if enemies[i].get_weapon_type() == "axe" and Global.player_current_weapon == Global.weapon.SPEAR:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "spear" and Global.player_current_weapon == Global.weapon.SWORD:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "sword" and Global.player_current_weapon == Global.weapon.AXE:
				damage = damage * 2
			#player.take_damage(damage)
			SignalManager.player_take_damage.emit(damage)
		await get_tree().create_timer(.5).timeout
	enemy_turn = false
	defend = false
	if potion_spawn: 
		collect_potion()
		potion_spawn = false
	disable_buttons(false)

func player_death():
	SceneTransition.change_scene("res://Scenes/Utility/upgrade.tscn")

func spawn_potion(pos):
	var rand_drop = rng.randi_range(1, 100)
	if rand_drop <= 70:
		var rand_potion = rng.randi_range(0, 1)
		if rand_potion:
			potion = health_potion.instantiate()
			#play spawn animation and sound effect
		else:
			potion = shield_potion.instantiate()
			#play spawn animation and sound effect
		potion_spawn = true
		potion.position = pos
		add_child(potion)

func collect_potion():
	if potion.name == "PotionHealth":
		Global.health_potion_count += 1
	elif potion.name == "PotionShield":
		Global.shield_potion_count += 1
	#play despawn animation
	potion.queue_free()

func show_actions_menu(value):
	actions_menu.visible = value
	item_menu.visible = !value
	
func _on_swap_weapon_pressed():
	SignalManager.weapon_swap.emit()
	enemies_turn()
	
func disable_buttons(value):
	$"../Actions/Panel/HBoxContainer/Attack".disabled = value
	$"../Actions/Panel/HBoxContainer/Swap Weapon".disabled = value
	$"../Actions/Panel/HBoxContainer/Defend".disabled = value
	$"../Actions/Panel/HBoxContainer/Items".disabled = value

func _on_defend_pressed():
	defend = true
	disable_buttons(true)
	enemies_turn()

func _on_items_pressed():
	show_actions_menu(false)

func _on_back_pressed():
	show_actions_menu(true)

func _on_shield_pressed():
	if Global.shield_potion_count > 0:
		Global.shield_potion_count -= 1
		#player.increase_shield()
		SignalManager.player_increase_shield.emit()
		show_actions_menu(true)
		await get_tree().create_timer(.5).timeout
		enemies_turn()

func _on_health_pressed():
	if Global.health_potion_count > 0:
		Global.health_potion_count -= 1
		#player.heal()
		SignalManager.player_increase_health.emit()
		show_actions_menu(true)
		await get_tree().create_timer(.5).timeout
		enemies_turn()
