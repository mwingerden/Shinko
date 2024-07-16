extends Node2D

var enemies = []
var player = null
var action_queue = []
var is_battling = false
var index = 0
var enemy_turn = false

func _ready():
	enemies = find_children("Enemy*")
	enemies[0]._select()
	player = get_child(0)
	
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
	$"../Actions/Panel/HBoxContainer/Attack".disabled = true
	$"../Actions/Panel/HBoxContainer/Defend".disabled = true
	$"../Actions/Panel/HBoxContainer/Item".disabled = true
	enemy_turn = true
	for i in enemies.size():
		if enemies[i].is_selected():
			enemies[i].take_damage(1)
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
	for i in enemies.size():
		#Perform Attack Animation
		player.take_damage(1)
		await get_tree().create_timer(.5).timeout
	$"../Actions/Panel/HBoxContainer/Attack".disabled = false
	$"../Actions/Panel/HBoxContainer/Defend".disabled = false
	$"../Actions/Panel/HBoxContainer/Item".disabled = false
	enemy_turn = false
	
