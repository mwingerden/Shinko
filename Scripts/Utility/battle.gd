extends Node2D

var enemies = []
var player = null
var action_queue = []
var is_battling = false
var index = 0
var enemy_turn = false
enum attack_type {NUETRAL, CRIT, RESIST}
var current_attack_type = attack_type.NUETRAL
var damage
var defend = false
@onready var actions_menu = $"../Actions"
@onready var item_menu = $"../Items"

func _ready():
	enemies = find_children("Enemy*")
	enemies[0]._select()
	player = get_child(0)
	show_actions_menu(true)
	
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
			
func switch_focus(x,y):
	enemies[x]._select()
	enemies[y]._unselect()

func _on_attack_pressed():
	disable_buttons(true)
	for i in enemies.size():
		if enemies[i].is_selected():
			damage = 1
			if enemies[i].get_weapon_type() == "axe" and player.current_weapon() == 0:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "spear" and player.current_weapon() == 1:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "sword" and player.current_weapon() == 2:
				damage = damage * 2
			enemies[i].take_damage(damage)
			if enemies[i].get_current_health() <= 0:
				#Play Death Animation Here
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
			if enemies[i].get_weapon_type() == "axe" and player.current_weapon() == 2:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "spear" and player.current_weapon() == 0:
				damage = damage * 2
			elif enemies[i].get_weapon_type() == "sword" and player.current_weapon() == 1:
				damage = damage * 2
			player.take_damage(damage)
		await get_tree().create_timer(.5).timeout
	enemy_turn = false
	defend = false
	disable_buttons(false)
	
func show_actions_menu(value):
	actions_menu.visible = value
	item_menu.visible = !value
	
func _on_swap_weapon_pressed():
	player.swap_weapon()
	
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
	player.increase_shield()

func _on_health_pressed():
	pass # Replace with function body.
