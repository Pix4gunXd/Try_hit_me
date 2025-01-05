extends CharacterBody2D

@onready var player = get_node("/root/Arena/Player")

var health = 25
var dmg = 5
var dmg_rate = 0.75
var scoreValue = 5
var contato_player = false

var desired_distance = 60.0  # Distance to maintain from the player
var separation_strength = 200.0  # Strength of the separation force

func _ready():
	$SpiderBot.play_walk() #Da play na animação

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300 #CHANGE SPEED HERE

	# Apply separation force if too close to the player
	var to_player = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < desired_distance:
		var separation_force = to_player.normalized() * -separation_strength
		velocity += separation_force

	move_and_slide()
	walk_face()
	die()

#MOVEMENT AND HURT

func walk_face():
	if velocity.x > 0:
		$SpiderBot.scale.x = -1  # Inverte o nó horizontalmente
	else:
		$SpiderBot.scale.x = 1

func take_damage(weapon_dmg):
	health -= weapon_dmg
	#Add Animation to being hurt
	

func die():
	if health <= 0:
		Score.atualizarScore(scoreValue)
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

func hurt():
	if contato_player == true:
		player.life -= dmg


#SIGNALS

func _on_hurtbox_body_entered(body):
	if body == player:
		contato_player = true
		hurt()


func _on_hurtbox_body_exited(body):
	if body == player:
		contato_player = false


func _on_dmg_rate_timeout():
	hurt()
