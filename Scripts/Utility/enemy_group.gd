extends Node2D

var enemies:Array = []
var index = 0

func _ready():
	enemies = get_children()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
			switch_focus(index, index + 1)
	if Input.is_action_just_pressed("ui_down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(index, index - 1)
			
func switch_focus(x,y):
	enemies[x]._selected()
	enemies[y]._unselect()
