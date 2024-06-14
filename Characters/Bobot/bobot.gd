extends Node2D

#CREATE FUNC TO PLAY ANIMATIONS

func play_walk_animation():
	%AnimationPlayer.play("Walk")

func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("Walk")
