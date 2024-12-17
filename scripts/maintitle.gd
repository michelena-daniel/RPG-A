extends Control

func _ready():
	pass

func _process(delta):
	pass

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/PlayerSelection.tscn")

func _on_exit_pressed():
	get_tree().quit()
