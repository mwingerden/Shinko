extends Node2D


func _on_button_pressed():
	await get_tree().create_timer(.5).timeout
	get_tree().quit()
