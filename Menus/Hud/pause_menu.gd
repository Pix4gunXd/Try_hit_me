extends Control

@onready var arena = $"../../"

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_resume_pressed():
	get_tree().paused = not get_tree().paused
	visible = false

func _on_restart_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().paused = not get_tree().paused
	AudioPlayer.play_music_bg()
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")

func _on_quit_pressed():
	get_tree().quit()


