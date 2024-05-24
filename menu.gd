extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus() #Define o foco no primeiro botão, permitindo controlar com as setas do mouse!

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main/game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
