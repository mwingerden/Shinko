extends CharacterBody2D

@onready var selected_sprite = $Selected
@onready var progress_bar = $Health
@onready var enemy_animation_player = $Self_Animation
@onready var selected_animation_player = $Selected_Animation
@onready var sprite_enemy = $Sprite2D
var selected = false
var weapon = Global.weapon.AXE

@export var MAX_HEALTH = 2
@export var EXP_DROP = 1
var current_health = MAX_HEALTH:
	set(value):
		current_health = value
		_update_progress_bar()
		_play_animation()
		
func _ready():
	current_health = MAX_HEALTH
	
@warning_ignore("unused_parameter")
func _process(delta):
	enemy_animation_player.play("move")
	selected_animation_player.play("selected")

func _update_progress_bar():
	progress_bar.value = (float(current_health) / MAX_HEALTH) * 100
	
func _play_animation():
	pass
	
func _select():
	selected_sprite.show()
	selected = true
	
func _unselect():
	selected_sprite.hide()
	selected = false
	
func is_selected():
	return selected
	
func take_damage(value):
	current_health = max(0, current_health - value)

func get_current_health():
	return current_health
	
func get_weapon_type():
	return weapon
	
func exp_drop():
	return EXP_DROP
	
func play_death_sx():
	AudioPlayer.play_FX(GlobalAudioSx.axe_enemy_death)

func attack():
	sprite_enemy.offset.x -= 20
	await get_tree().create_timer(.3).timeout 
	sprite_enemy.offset.x += 20

func hurt():
	sprite_enemy.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_enemy.visible = true
	await get_tree().create_timer(.05).timeout 
	sprite_enemy.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_enemy.visible = true
	await get_tree().create_timer(.05).timeout 
	sprite_enemy.visible = false
	await get_tree().create_timer(.05).timeout 
	sprite_enemy.visible = true
