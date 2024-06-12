extends Area2D

var max_ammo = 21
var ammo = max_ammo
var dmg = 12
var is_reloading = false
var shoot_delay = 0.08
var time_since_last_shot = 0.0

func _ready():
	pass

func _physics_process(_delta):
	%Marker2D.look_at(get_global_mouse_position())

func shoot():
	if is_reloading or ammo <= 0:
		return

	const BULLET = preload("res://Weapons/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	new_bullet.dmg = dmg  # Assign weapon damage to the bullet
	
	get_tree().root.add_child(new_bullet)  # Add to scene root or a dedicated node
	
	$AnimationPlayer.play("shoot")
	ammo -= 1

func reload():
	if is_reloading or ammo == max_ammo:
		return

	is_reloading = true
	%Reload_timer.start()
	%AnimationPlayer.play("reload")

# SIGNALS

func _on_reload_timer_timeout():
	is_reloading = false
	ammo = max_ammo

func _process(delta):
	if is_reloading:
		return

	if Input.is_action_pressed("shoot") and ammo > 0:
		time_since_last_shot += delta
		if time_since_last_shot >= shoot_delay:
			shoot()
			time_since_last_shot = 0.0
	else:
		time_since_last_shot = 0.0
