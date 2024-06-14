extends Node

var score = 0
var max_score = 0

func atualizarScore(value) -> void: #Atualiza a pontuação
	score = score + value

func resetScore(): #Reseta a pontuação
	score = 0

func end_game(): # Atualiza a pontuação maxíma
	max_score = score
