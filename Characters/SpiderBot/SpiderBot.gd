extends Node2D

@onready var andar = $AnimatedSprite2D

func play_walk():
	andar.play()
