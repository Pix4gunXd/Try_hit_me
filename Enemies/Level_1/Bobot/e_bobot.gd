extends CharacterBody2D

#BUG: Se inimigo enconstar no jogador 0.1sec antes da função hurt() ser chamada, inimigo causa 20 de dano!!!

@onready var player = get_node("/root/game/Player")

var health = 100
var dmg = 10;
var dmg_rate = 0.5
var xp = null

var contato_player = false

<<<<<<< HEAD
func _ready():
	$Bobot.play_walk_animation()


=======
>>>>>>> 92abd62b295770184464665bbbd19a0fb1c0b0c3
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 250
	move_and_slide()
	
	walk_face()
	

func walk_face():
<<<<<<< HEAD
=======
	$Bobot.play_walk_animation()
>>>>>>> 92abd62b295770184464665bbbd19a0fb1c0b0c3
	
	if  velocity.x > 0:
		$Bobot.scale.x = -1  # Inverte o nó horizontalmente
	else:
		$Bobot.scale.x = 1


func take_damage(weapon_dmg):
<<<<<<< HEAD
	%Bobot.play_hurt()
	health -= weapon_dmg
	
=======
	health -= weapon_dmg
	%Bobot.play_hurt()
>>>>>>> 92abd62b295770184464665bbbd19a0fb1c0b0c3
	
	if health == 0:
		queue_free()
		#add animation to being hurt
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		

func hurt():
	if contato_player == true:
		player.life -= dmg 

#SIGNALS

# Verifica se algo enconstou na Hurtbox (Area2D)
func _on_hurtbox_body_entered(body):
	if body == player:
		contato_player = true
		hurt()

func _on_hurtbox_body_exited(body):
	if body == player:
		contato_player = false
	

func _on_dmg_rate_timeout():
	hurt()
