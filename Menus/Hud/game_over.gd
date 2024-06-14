extends Control

# Criar funçao que identifique quando o jogo se encerra com a morte do jogador e ative a tela de GameOver dando opção de reiniciar ou sair
# ATENÇÃO!!! A PONTUAÇÃO DO JOGADOR TAMBÉM DEVE APARECER NESTA TELA AO FINALIZAR

func gameOver() -> void:
	get_tree().paused = not get_tree().paused
	visible = true
	Score.end_game()
	$Score.text = str(Score.score)
	$HighScore.text = str(Score.max_score)


func _on_restart_pressed():
	get_tree().paused = not get_tree().paused
	Score.resetScore() #Reinicia o score
	get_tree().reload_current_scene()
	Score.score = 0
	


func _on_main_menu_pressed():
	get_tree().paused = not get_tree().paused
	AudioPlayer.play_music_bg() #Volta a tocar a música
	Score.resetScore() #Reinicia o score
	get_tree().change_scene_to_file("res://Menus/MainMenu/menu.tscn")
	Score.score = 0
	


func _on_quit_pressed():
	get_tree().quit()
