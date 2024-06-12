extends Node

var score = 0

func atualizarScore(value) -> void: #Atualiza a pontuação
	score = score + value

func resetScore(): #Reseta a pontuação
	score = 0
