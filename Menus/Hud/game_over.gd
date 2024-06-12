extends Control

# Criar funçao que identifique quando o jogo se encerra com a morte do jogador e ative a tela de GameOver dando opção de reiniciar ou sair
# ATENÇÃO!!! A PONTUAÇÃO DO JOGADOR TAMBÉM DEVE APARECER NESTA TELA AO FINALIZAR

func gameOver() -> void:
	get_tree().paused = not get_tree().paused
	visible = true


func _on_restart_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().reload_current_scene()
	


func _on_main_menu_pressed():
		get_tree().paused = not get_tree().paused
		AudioPlayer.play_music_bg()
		get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
