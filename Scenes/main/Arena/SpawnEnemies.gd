extends Node2D

var enemy_count = 0
var max_enemies = 10

var spider_count = 0
var max_spiders = 10

@warning_ignore("unused_parameter")
func _process(delta):
	if $Player.life <= 0:
		%GameOver.gameOver()
	
	#AudioPlayer.stop_music_bg(
	AudioPlayer.stop_music_bg()


func _on_timer_timeout():
	# Decide aleatoriamente qual inimigo spawnar
	var rand_enemy = randi() % 3  # Gera um número entre 0 e 1
	match rand_enemy:
		0:
			spawn_enemy()
		1:
			spawn_spider()
		2: 
			spawn_spider()

func spawn_enemy():
	if enemy_count < max_enemies:
		var path_follow = get_node("ColorRect/Path2D/PathFollow2D")
		if path_follow:
			var new_enemy = preload("res://Enemies/Level_1/Bobot/e_bobot.tscn").instantiate()
			path_follow.progress_ratio = randf()
			new_enemy.global_position = path_follow.global_position
			add_child(new_enemy)
			enemy_count += 1
		else:
			print("Erro: 'PathFollow2D' não encontrado.")
	else:
		print("Número máximo de inimigos atingido.")
		get_node("Timer").stop()

func spawn_spider():
	if spider_count < max_spiders:
		var path_follow = get_node("ColorRect/Path2D/PathFollow2D")
		if path_follow:
			var new_spider = preload("res://Enemies/Level_1/SpiderBot/e_spider_bot.tscn").instantiate()
			path_follow.progress_ratio = randf()
			new_spider.global_position = path_follow.global_position
			add_child(new_spider)
			spider_count += 1
		else:
			print("Erro: 'PathFollow2D' não encontrado.")
	else:
		print("Número máximo de spiders atingido.")
		get_node("Timer").stop()

func _on_nova_rodada_timeout():
	reset_enemy_count()
	reset_spider_count()

func reset_enemy_count():
	enemy_count = 0
	get_node("Timer").start()

func reset_spider_count():
	spider_count = 0
	get_node("Timer").start()
