extends Node2D



func spawn_enemy():
	var path_follow = get_node("Player/Path2D/PathFollow2D")
	if path_follow:
		var new_enemy = preload("res://Enemies/Level_1/Bobot/e_bobot.tscn").instantiate()
		path_follow.progress_ratio = randf()
		new_enemy.global_position = path_follow.global_position
		add_child(new_enemy)
	else:
		print("Erro: 'PathFollow2D' não encontrado.")


func _on_timer_timeout():
	spawn_enemy()
