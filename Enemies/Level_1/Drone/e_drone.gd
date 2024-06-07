extends CharacterBody2D

@onready var player = get_node("/root/Arena/Player")

var health = 30
var dmg = 10
var dmg_rate = 0.5
var xp = null
var contato_player = false

var max_ammo = 120
var ammo = max_ammo

var desired_distance = 500.0  # Distance to maintain from the player
var separation_strength = 200.0  # Strength of the separation force
var shooting_distance = 500.0  # Distance within which the enemy will start shooting

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < shooting_distance:
		shoot()
	else:
		velocity = direction * 350

		if distance_to_player < desired_distance:
			var separation_force = direction.normalized() * -separation_strength
			velocity += separation_force
		
		move_and_slide()
	
	walk_face()

func walk_face():
	$Drone.play_walk_animation()
	
	if velocity.x > 0:
		$Drone.scale.x = -1  # Inverte o nó horizontalmente
	else:
		$Drone.scale.x = 1

func shoot():
	if ammo <= 0:
		return
	
	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	new_bullet.weapon = self
	
	get_parent().add_child(new_bullet)
	
	ammo -= 1

func take_damage(weapon_dmg):
	health -= weapon_dmg
	$Drone.play_hurt()
	
	if health <= 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

func hurt():
	if contato_player == true:
		player.life -= dmg

# SIGNALS

func _on_hurtbox_body_entered(body):
	if body == player:
		contato_player = true
		hurt()

func _on_hurtbox_body_exited(body):
	if body == player:
		contato_player = false

func _on_dmg_rate_timeout():
	hurt()
