extends Control

func _ready():
	$TitleAnimation.play("Title")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")
