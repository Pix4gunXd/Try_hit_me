extends Node2D

# Variável para contar o número de inimigos
var enemy_count = 0
# Limite máximo de inimigos
var max_enemies = 10

func spawn_enemy():
	if enemy_count < max_enemies:
		var path_follow = get_node("ColorRect/Path2D/PathFollow2D")
		if path_follow:
			var new_enemy = preload("res://Enemies/Level_1/Bobot/e_bobot.tscn").instantiate()
			path_follow.progress_ratio = randf()
			new_enemy.global_position = path_follow.global_position
			add_child(new_enemy)
			
			# Aumenta o contador de inimigos
			enemy_count += 1
		else:
			print("Erro: 'PathFollow2D' não encontrado.")
	else:
		print("Número máximo de inimigos atingido.")
		get_node("Timer").stop()  # Pare o timer para impedir mais spawns

func _on_timer_timeout():
	spawn_enemy()

# Você pode chamar esta função para reiniciar o spawn de inimigos, se necessário
func reset_enemy_count():
	enemy_count == 0
	get_node("Timer").start()  # Reinicie o timer para permitir novos spawns
