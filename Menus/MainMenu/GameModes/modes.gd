extends Control


func _on_arena_pressed():
	get_tree().change_scene_to_file("res://Scenes/main/Arena/Arena.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")
