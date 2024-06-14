extends Control

func _ready():
	$TitleAnimation.play("Title")
	$High_Score_number.text = str(Score.max_score)

func _on_arena_pressed():
	get_tree().change_scene_to_file("res://Scenes/main/Arena/Arena.tscn")


func _on_arena_mouse_entered():
	$ButtonHover.play()
	

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")

func _on_back_mouse_entered():
	$ButtonHover.play()

#-------------------------------------------



