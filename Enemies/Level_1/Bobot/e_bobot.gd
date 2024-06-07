extends CharacterBody2D

#BUG: Se inimigo enconstar no jogador 0.1sec antes da função hurt() ser chamada, inimigo causa 20 de dano!!!

@onready var player = get_node("/root/Arena/Player")

var health = 60
var dmg = 10
var dmg_rate = 0.5
var xp = null
var contato_player = false

# Parameters for separation logic
var desired_distance = 60.0  # Distance to maintain from the player
var separation_strength = 200.0  # Strength of the separation force

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 250

	# Apply separation force if too close to the player
	var to_player = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < desired_distance:
		var separation_force = to_player.normalized() * -separation_strength
		velocity += separation_force

	move_and_slide()
	
	walk_face()

func walk_face():
	$Bobot.play_walk_animation()
	
	if velocity.x > 0:
		$Bobot.scale.x = -1  # Inverte o nó horizontalmente
	else:
		$Bobot.scale.x = 1

func take_damage(weapon_dmg):
	health -= weapon_dmg
	$Bobot.play_hurt()
	
	if health <= 0:
		queue_free()
		# Add animation to being hurt
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

func hurt():
	if contato_player == true:
		player.life -= dmg

# SIGNALS

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
