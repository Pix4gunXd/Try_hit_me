extends Node2D

# CREATE FUNC TO PLAY THE ANIMATIONS

func play_idle_animation():
	%AnimationPlayer.play("idle")

func play_walk_animation():
	%AnimationPlayer.play("walk")
