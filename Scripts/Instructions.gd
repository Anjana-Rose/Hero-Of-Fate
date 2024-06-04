extends Control

func _on_play_pressed():
	var scene = "res://Scenes/Real_Level_1.tscn"
	get_tree().change_scene_to_file(scene)
