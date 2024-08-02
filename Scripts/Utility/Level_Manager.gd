extends Node

var FILE_PATH = "res://Scenes/Levels/level_"
var level_count

func _ready():
	level_count = dir_contents("res://Scenes/Levels/")
	#print(level_count)

func next_level(current_level):
	var next_level = current_level.to_int() + 1
	if next_level > level_count:
		SceneTransition.change_scene("res://Scenes/Menus/win_screen.tscn")
	else:
		SceneTransition.change_scene(FILE_PATH + str(next_level) + ".tscn")

func dir_contents(path):
	var count = 0
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			count += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	return count
