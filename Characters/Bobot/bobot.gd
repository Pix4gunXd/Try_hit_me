extends Node2D

#CREATE FUNC TO PLAY ANIMATIONS

func play_walk_animation():
	%Bobot_2.play("walk")
	%AnimationPlayer.play("Walk")

func play_hurt():
	%Bobot_2.play("hurt")
	%Bobot_2.queue("walk")
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("Walk")
