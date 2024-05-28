extends Control

func _ready():
	$TitleAnimation.play("Title")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")

func _on_back_mouse_entered():
	$ButtonHover.play()
